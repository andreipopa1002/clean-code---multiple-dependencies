//
//  Result.swift
//  Headlines
//
//  Created by Andrei Popa on 15/07/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation

public enum Result<ResultType, ErrorType> {
    case success(ResultType)
    case failure(ErrorType)
}

extension Result {
    
    public var result: ResultType? {
        guard case .success(let result) = self else {
            return nil
        }
        return result
    }
    
    public var error: ErrorType? {
        guard case .failure(let error) = self else {
            return nil
        }
        return error
    }
    
    public var isSuccess: Bool {
        guard case .success = self else {
            return false
        }
        
        return true
    }
}

extension Result where ResultType: Equatable {
    
    public func isSuccessWithResult(_ result: ResultType?) -> Bool {
        guard case .success(let r) = self else {
            return false
        }
        return r == result
    }
}

extension Result where ErrorType: Equatable {
    
    public func isFailureWithError(_ error: ErrorType?) -> Bool {
        guard case .failure(let e) = self else {
            return false
        }
        return e == error
    }
}
