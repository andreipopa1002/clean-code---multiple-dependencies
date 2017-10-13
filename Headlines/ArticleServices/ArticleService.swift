//
//  ArticleService.swift
//  Headlines
//
//  Created by Andrei Popa on 15/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

fileprivate let APIKey = "enj8pstqu5yat6yesfsdmd39" // this should reside into a plist and fetched on demand


final class ArticleService: ArticleServiceInterface {
    struct ArticleServiceConstants {
        static let unexpectedDataDescription = "Received unexpectedData"
        static let unexpectedDataSuggestion = "Please try again"
    }
    
    private let url: String
    private let requestFetcher: RequestFetcherInterface
    
    init(with url: String = "http://content.guardianapis.com/search?q=fintech&show-fields=main,body&api-key=\(APIKey)", requestFetcher: RequestFetcherInterface = RequestFetcher()) {
        self.url = url
        self.requestFetcher = requestFetcher
    }
    
    func fetchArticles(completion: @escaping ((ArticleServiceResponse) -> Void)) {
        requestFetcher.fetchJSON(from: url, completion:{ [weak self] response in
            switch response {
            case .success(let successJSON):
                self?.handleFecthedJSON(successJSON: successJSON, completion: completion)
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        })
    }
    
    private func handleFecthedJSON(successJSON: Any, completion: @escaping ((ArticleServiceResponse) -> Void)) {
        guard let json = successJSON as? [String : Any], let data = json["response"] as? [String : Any], let results = data["results"] as? [[String: Any]] else {
            completion(.failure(ErrorMessage(description: ArticleServiceConstants.unexpectedDataDescription,
                                             suggestion: ArticleServiceConstants.unexpectedDataSuggestion)))
            return
        }
        completion(.success(results.flatMap { Article(dictionary: $0)}))
    }
}
