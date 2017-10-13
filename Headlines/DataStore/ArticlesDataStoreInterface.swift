//
//  ArticleDataStoreInterface.swift
//  Headlines
//
//  Created by Andrei Popa on 15/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

typealias ArticlesDataStoreResponse = (Result<[Article], ErrorMessage>)

protocol ArticlesDataStoreInterface: class {
    var articles: [Article] {get set}
    func fetchArticles(completion: @escaping((ArticlesDataStoreResponse) -> Void))
    func addToFavourites(article: Article) -> Bool
    func removeFromFavorites(article: Article) -> Bool
    func article(with id: String) -> Article?
}
