//
//  ArticlePresenterInterface.swift
//  Headlines
//
//  Created by Andrei Popa on 16/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

struct ArticleViewModel {
    let id: String
    let headline: String
    let body: String
    let publishedDataAsString: String
    let imageURL: URL?
    var isFavorite: Bool
}

protocol ArticlePresenterInterface {
    func loadingArticles()
    func show(articles: [Article])
    func addedToFavorites(articleWith articleId: String, articles: [Article])
    func removedFromFavorites(articleWith articleId: String, articles: [Article])
    func presentFavorites()
    
}
