//
//  ViewController.swift
//  Headlines
//
//  Created by Joshua Garnham on 09/05/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import SDWebImage

class ArticlesViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    var interactor: ArticlesInteractorInterface?
    var articles = [ArticleViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        interactor?.provideArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension ArticlesViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCollectionViewCell", for: indexPath) as? ArticleCollectionViewCell else {
            fatalError("cell should be of type ArticleCollectionViewCell")
        }
        
        cell.headlineLabel.text = articles[indexPath.item].headline
        cell.bodyLabel.text = articles[indexPath.item].body
        cell.articleImageView.sd_setImage(with: articles[indexPath.item].imageURL)
        cell.mark(favorite: articles[indexPath.item].isFavorite)
        cell.delegate = self
        
        return cell
    }
}

extension ArticlesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width,
                      height: collectionView.bounds.size.height - topLayoutGuide.length)
    }
}

extension ArticlesViewController: ArticleViewInterface {
    func showLoading() {
        spinner.startAnimating()
    }
    
    func viewModels(models: [ArticleViewModel]) {
        spinner.stopAnimating()
        articles = models
    }
    
    func refresh() {
        self.collectionView.reloadData()
    }
    
    func markAsFavorite(itemAtIndex: Int) {
        guard let cell = collectionView.cellForItem(at: IndexPath(item: itemAtIndex, section: 0)) as? ArticleCollectionViewCell else {
            return
        }
        cell.mark(favorite: true)
    }
    
    func unMarkAsFavorite(itemAtIndex: Int) {
        guard let cell = collectionView.cellForItem(at: IndexPath(item: itemAtIndex, section: 0)) as? ArticleCollectionViewCell else {
            return
        }
        cell.mark(favorite: false)
    }
}

extension ArticlesViewController: ArticleCollectionViewCellDelegate {
    func didTapAddToFavourites(sender: ArticleCollectionViewCell) {
        guard let cellIndexPath = collectionView.indexPath(for: sender) else {
            return
        }
        
        interactor?.toggleFavorites(for: articles[cellIndexPath.item].id)
    }
    
    func didTapFavourites(sender: ArticleCollectionViewCell) {
        interactor?.showFavorites()
    }
}
