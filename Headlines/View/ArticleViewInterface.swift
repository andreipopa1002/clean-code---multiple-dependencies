//
//  ArticleViewInterface.swift
//  Headlines
//
//  Created by Andrei Popa on 17/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

protocol ArticleViewInterface: class {
    func showLoading()
    func viewModels(models: [ArticleViewModel])
    func refresh()
    func markAsFavorite(itemAtIndex: Int)
    func unMarkAsFavorite(itemAtIndex: Int)
}
