//
//  ConnectionError.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import Foundation

public protocol ConnectionError: Error {
    
    var isInternetConnectionError : Bool {get}
    
}

public extension Error {
    var isInternetConnectionError: Bool {
        guard let error = self as? ConnectionError, error.isInternetConnectionError else {
            return false
        }
        return true
    }
}
