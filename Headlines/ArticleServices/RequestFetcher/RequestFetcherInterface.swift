//
//  RequestFetcherInterface.swift
//  Headlines
//
//  Created by Andrei Popa on 15/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

typealias JSONFetchResponse = (Result<Any,ErrorMessage>)

protocol RequestFetcherInterface {    
    func fetchJSON(from url: String, completion: @escaping ((_ result: JSONFetchResponse) -> Void))
}
