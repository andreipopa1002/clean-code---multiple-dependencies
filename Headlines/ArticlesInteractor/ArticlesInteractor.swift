//
//  ArticlesInteractor.swift
//  Headlines
//
//  Created by Andrei Popa on 15/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

final class ArticlesInteractor: ArticlesInteractorInterface {
    
    let dataStore: ArticlesDataStoreInterface
    let presenter: ArticlePresenterInterface
    
    init(dataStore: ArticlesDataStoreInterface = ArticlesDataStore(),
         presenter: ArticlePresenterInterface) {
        self.dataStore = dataStore
        self.presenter = presenter
    }
   
    
    func provideArticles() {
        presenter.loadingArticles()
        dataStore.fetchArticles { [weak self] articleResponse in
            switch articleResponse{
            case .failure(_):
                break
            case .success(let articles):
                self?.handleFetched(articles: articles)
            }
        }
    }
    
    func toggleFavorites(for articleId: String) {
        guard let article = dataStore.article(with: articleId) else { return }
        
        if article.isFavorite {
            _ = dataStore.removeFromFavorites(article: article)
            presenter.removedFromFavorites(articleWith: articleId, articles: dataStore.articles)
        } else {
            _ = dataStore.addToFavourites(article: article)
            presenter.addedToFavorites(articleWith: articleId, articles: dataStore.articles)
        }
    }
    
    func showFavorites() {
        presenter.presentFavorites()
    }
}

extension ArticlesInteractor {
// MARK: Private methods
    fileprivate func handleFetched(articles: [Article]) {
        dataStore.articles = articles
        presenter.show(articles: dataStore.articles)
    }
}
