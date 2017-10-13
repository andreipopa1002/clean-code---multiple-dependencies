//
//  ArticleRouter.swift
//  Headlines
//
//  Created by Andrei Popa on 18/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit

class ArticleRouter: ArticleRouterInterface {
    let navigationController: UINavigationController
    
    init(navigation: UINavigationController) {
        navigationController = navigation
    }
    
    func routeToFavorites() {
        navigationController.pushViewController(FavouritesViewController(), animated: true)
        navigationController.setNavigationBarHidden(false, animated: true)
    }
}
