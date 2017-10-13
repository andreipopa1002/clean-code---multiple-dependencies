//
//  FavouritesViewController.swift
//  Headlines
//
//  Created by Joshua Garnham on 09/05/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import SDWebImage

class FavouritesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var articleSelected: ((IndexPath) -> Void)?
    
    var persitenceManager = PersistenceManager()
    var allArticles: [Article] = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        allArticles = persitenceManager.articles()
        self.tableView.reloadData()
    }
    
    func doneButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}

extension FavouritesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // TODO: Perform search
    }
}

extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let article = allArticles[indexPath.row]
        cell.textLabel?.text = article.headline
        cell.detailTextLabel?.text = article.published?.description
        let placeholderImage = UIImage.init(color: UIColor.white, size: CGSize(width: 73, height: 44
        ))
        cell.imageView?.sd_setImage(with: article.imageURL, placeholderImage: placeholderImage)
        cell.imageView?.contentMode = .scaleAspectFit
        cell.setNeedsLayout()
        
        return cell
    }
}

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
