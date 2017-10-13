//
//  ArticleServiceInterface.swift
//  Headlines
//
//  Created by Andrei Popa on 15/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

typealias ArticleServiceResponse = (Result<[Article], ErrorMessage>)

protocol ArticleServiceInterface {
    func fetchArticles(completion: @escaping ((ArticleServiceResponse) -> Void))
}
