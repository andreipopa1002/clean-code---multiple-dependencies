//
//  ErrorMessage.swift
//  Headlines
//
//  Created by Andrei Popa on 15/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

public struct ErrorMessage: Equatable, Error {
    public let description: String
    public let suggestion: String
    public var developerMessage: String?
    
    public init(description: String, suggestion: String) {
        self.description = description
        self.suggestion = suggestion
    }
    
    public init(nsError: NSError) {
        self.description = nsError.localizedDescription
        self.suggestion = nsError.localizedRecoverySuggestion ?? "Unexpected Error !!!"
    }
    
    public func errorByAddingDeveloperMessage(_ message: String?) -> ErrorMessage {
        var error = self
        error.developerMessage = message
        return error
    }
}

public func ==(lhs: ErrorMessage, rhs: ErrorMessage) -> Bool {
    return lhs.description == rhs.description
        && lhs.suggestion == rhs.suggestion
        && lhs.developerMessage == rhs.developerMessage
}
