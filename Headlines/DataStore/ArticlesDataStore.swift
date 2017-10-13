//
//  ArticleDataStore.swift
//  Headlines
//
//  Created by Andrei Popa on 15/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

class ArticlesDataStore: ArticlesDataStoreInterface {
    var articles: [Article] {
        didSet {
            let favoriteArticles = persistenceStore.articles()
            articles = articles.map({
                var article = $0
                article.isFavorite = false
                if  let _ = favoriteArticles.first(where: { $0.id == article.id }) {
                    article.isFavorite = true
                }
                return article
            })
        }
    }
    
    private let service: ArticleServiceInterface
    private let persistenceStore: PersistenceManagerInterface
    
    init(service: ArticleServiceInterface = ArticleService(),
         persistenceStore: PersistenceManagerInterface = PersistenceManager()) {
        self.service = service
        self.persistenceStore = persistenceStore
        self.articles = [Article]()
    }

    func fetchArticles(completion: @escaping ((ArticlesDataStoreResponse) -> Void)) {
        service.fetchArticles(completion: completion)
    }
    
    func addToFavourites(article: Article) -> Bool {
        persistenceStore.save(article: article)
        refreshArticles()
        return true
    }
    
    func removeFromFavorites(article: Article) -> Bool {
        persistenceStore.delete(article: article)
        refreshArticles()
        return true
    }
    
    func article(with id: String) -> Article? {
        return articles.first(where: {$0.id == id})
    }
}

extension ArticlesDataStore {
    //MARK: private methods
    fileprivate func refreshArticles() {
        let currentArticles = articles
        articles = currentArticles
    }
}
