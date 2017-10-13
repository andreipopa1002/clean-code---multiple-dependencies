//
//  PersistanceManager.swift
//  Headlines
//
//  Created by Andrei Popa on 16/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation
import RealmSwift

class ArticleObject: Object {
    dynamic var id: String?
    dynamic var headline: String?
    dynamic var body: String?
    dynamic var published: Date?
    dynamic var imageURLAsString: String?
}

class PersistenceManager: PersistenceManagerInterface {
    private let realm = try! Realm() // TODO: no force unwrapp
    
    func save(article: Article) {
        let articleObject = convertArticleToArticleObject(article: article)
        
        // TODO: no force unwrapp
        _ = try? realm.write {
//            realm.delete(articleObject)
            realm.add(articleObject)
        }
    }
    
    func delete(article: Article) {
        // TODO: fix this: most likely nost the best way to do it
        // TODO: no force unwrapp
        let allArticleObjects = Array(realm.objects(ArticleObject.self))
        
        let articleObjectWithId = allArticleObjects.first(where: { $0.id == article.id })
        if let articleObjectWithId = articleObjectWithId {
            _ = try? realm.write {
                realm.delete(articleObjectWithId)
            }
        }
    }
    
    func articles() -> [Article] {
        // TODO: no force unwrapp
        let all = realm.objects(ArticleObject.self)
        return convertArticleObjectsToArticles(articleObjects: Array(all))
    }
    
    // MARK: private functions
    private func convertArticleObjectsToArticles(articleObjects: [ArticleObject]) -> [Article] {
        return articleObjects.map({
            Article(id: $0.id!,
                    headline: $0.headline,
                    body: $0.body,
                    published: $0.published,
                    imageURL:  URL(string: $0.imageURLAsString!),
                    isFavorite: true)
        })
    }
    
    private func convertArticleToArticleObject(article: Article) -> ArticleObject{
        let articleObject = ArticleObject()
        articleObject.id = article.id
        articleObject.headline = article.headline
        articleObject.body = article.body
        articleObject.imageURLAsString = article.imageURL?.absoluteString
        return articleObject
    }
}
 
