//
//  RequestFetcher.swift
//  Headlines
//
//  Created by Andrei Popa on 15/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation
import Alamofire

final class RequestFetcher: RequestFetcherInterface {
    private struct ErrorStrings {
        static let unexpectedDataDescription = "Unexpected Data"
        static let unexpectedDataSuggestion = "Try again"
    }
    
    func fetchJSON(from url: String, completion: @escaping ((JSONFetchResponse) -> Void)) {
        Alamofire.request(url, encoding: JSONEncoding.default).responseJSON { [weak self] response in
            if let error = response.result.error {
                completion(.failure(ErrorMessage(description: error.localizedDescription,
                                                 suggestion: ErrorStrings.unexpectedDataSuggestion)))
            } else {
                self?.handleSuccess(with: response, completion: completion)
            }
        }
    }
    
    func handleSuccess(with response: DataResponse<Any>, completion: @escaping ((JSONFetchResponse) -> Void)) {
        if let responseValue = response.result.value {
            completion(.success(responseValue))
        } else {
            completion(.failure(ErrorMessage(description: ErrorStrings.unexpectedDataDescription,
                                             suggestion: ErrorStrings.unexpectedDataSuggestion)))
        }
    }
}
