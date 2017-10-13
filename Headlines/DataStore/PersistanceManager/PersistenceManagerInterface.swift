//
//  PersistanceManagerInterface.swift
//  Headlines
//
//  Created by Andrei Popa on 16/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

protocol PersistenceManagerInterface {
    func save(article: Article) // probably should return a bool
    func delete(article: Article) // probably should return a bool
    func articles() -> [Article]
}
