//
//  ArticlePresenter.swift
//  Headlines
//
//  Created by Andrei Popa on 16/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

class ArticlePresenter {
    weak var view: ArticleViewInterface?
    let router: ArticleRouterInterface
    
    init(router: ArticleRouterInterface) {
        self.router = router
    }
}

extension ArticlePresenter: ArticlePresenterInterface {

    func loadingArticles() {
        view?.showLoading()
    }
    
    func show(articles: [Article]) {
        view?.viewModels(models: viewModels(from: articles))
        view?.refresh()
    }
    
    func addedToFavorites(articleWith articleId: String, articles: [Article]) {
        let models = viewModels(from: articles)
        view?.viewModels(models: models)
        if let index = models.index(where: {$0.id == articleId }) {
            view?.markAsFavorite(itemAtIndex: index)
        }
    }
    
    func removedFromFavorites(articleWith articleId: String, articles: [Article]) {
        let models = viewModels(from: articles)
        view?.viewModels(models: models)
        if let index = models.index(where: {$0.id == articleId }) {
            view?.unMarkAsFavorite(itemAtIndex: index)
        }
    }
    
    func presentFavorites() {
        router.routeToFavorites()
    }
    
    private func viewModels(from articles:[Article]) -> [ArticleViewModel] {
        let articlesWithId = articles.filter({ $0.id != "" })
        let viewModels = articlesWithId.map {
            return ArticleViewModel(id: $0.id,
                                    headline: $0.headline ?? "",
                                    body: $0.body ?? "",
                                    publishedDataAsString: "",
                                    imageURL: $0.imageURL,
                                    isFavorite: $0.isFavorite )
        }
        
        return viewModels.filter {
            // there is no business case for these articles - I will not show them on the UI
            $0.headline.uppercased() != "corrections and clarifications".uppercased()
        }
    }
}
