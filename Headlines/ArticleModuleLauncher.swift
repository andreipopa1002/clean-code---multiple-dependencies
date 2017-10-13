//
//  ArticleModuleLauncher.swift
//  Headlines
//
//  Created by Andrei Popa on 17/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit

class ArticleModuleLauncher {
    func launchArticleModule(in navigationController: UINavigationController) -> UIViewController {
        let viewController = UIStoryboard(name: "Articles", bundle: nil).instantiateViewController(withIdentifier: "ArticlesViewController") as! ArticlesViewController
        let dataStore = ArticlesDataStore()
        let router = ArticleRouter(navigation: navigationController)
        let presenter = ArticlePresenter(router: router)
        presenter.view = viewController
        let interactor = ArticlesInteractor(dataStore: dataStore, presenter: presenter)
        viewController.interactor = interactor
        
        return viewController
    }
}
