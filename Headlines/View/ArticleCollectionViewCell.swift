//
//  ArticleCollectionViewCell.swift
//  Headlines
//
//  Created by Andrei Popa on 17/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit

protocol ArticleCollectionViewCellDelegate: class {
    func didTapAddToFavourites(sender: ArticleCollectionViewCell)
    func didTapFavourites(sender: ArticleCollectionViewCell)
}

class ArticleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var articleImageView: UIImageView!
    @IBOutlet var headlineLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var starButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    
    weak var delegate: ArticleCollectionViewCellDelegate?
    
    @IBAction func addToFavouritesButtonTapped(_ sender: UIButton) {
        self.delegate?.didTapAddToFavourites(sender: self)
    }
    
    @IBAction func favouritesButtonTapped(_ sender: UIButton) {
        self.delegate?.didTapFavourites(sender: self)
    }
    
    func mark(favorite: Bool) {
        if favorite {
            starButton.setBackgroundImage(UIImage(named: "favourite-on"), for: .normal)
        } else {
            starButton.setBackgroundImage(UIImage(named: "favourite-off"), for: .normal)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scrollView.contentOffset = .zero
    }
}
