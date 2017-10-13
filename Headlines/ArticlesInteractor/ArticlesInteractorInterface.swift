//
//  ArticlesInteractorInterface.swift
//  Headlines
//
//  Created by Andrei Popa on 15/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

protocol ArticlesInteractorInterface {
    func provideArticles()
    func toggleFavorites(for articleId: String)
    func showFavorites()
}
