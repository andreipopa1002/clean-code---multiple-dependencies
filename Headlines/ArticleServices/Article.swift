//
//  Article.swift
//  Headlines
//
//  Created by Andrei Popa on 16/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation
import ISO8601

struct Article {
    // all these lets should go into a protocol to make sure that Article and ArticleObject implement the same properties
    let id: String
    let headline: String?
    let body: String?
    let published: Date?
    let imageURL: URL?
    var isFavorite: Bool
    
    private struct FieldsConstants {
        static let webTitle = "webTitle"
        static let webPublicationDate = "webPublicationDate"
        static let body = "body"
        static let main = "main"
        static let fields = "fields"
    }
    
    init(id: String, headline: String?, body: String?, published: Date?, imageURL: URL?, isFavorite: Bool = false) {
        self.id = id
        self.headline = headline
        self.body = body
        self.published = published
        self.imageURL = imageURL
        self.isFavorite = isFavorite
    }
    
    init(dictionary: [String : Any]) {
        if let foundId = dictionary["id"] as? String {
            id = foundId
        } else {
            //special case - needs special handling - currently not handled correctly
            id = "not foud!!!"
        }
        headline = dictionary[FieldsConstants.webTitle] as? String
        
        if let publicationDate = dictionary[FieldsConstants.webPublicationDate] as? String {
            published = NSDate(iso8601String: publicationDate) as? Date
        } else {
            published = nil
        }
        
        if let fields = dictionary[FieldsConstants.fields] as? [String: String]  {
            body = fields[FieldsConstants.body]?.stringByStrippingTags()
            imageURL = fields[FieldsConstants.main]?.imageUrl()
        } else {
            body = nil
            imageURL = nil
        }
        isFavorite = false
    }
}

extension Article: Equatable {
    public static func ==(lhs: Article, rhs: Article) -> Bool {
        return lhs.id == rhs.id &&
        lhs.headline == rhs.headline &&
        lhs.published == rhs.published &&
        lhs.imageURL == rhs.imageURL
    }
}
