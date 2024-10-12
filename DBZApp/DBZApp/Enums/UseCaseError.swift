//
//  UseCaseError.swift
//  DBZApp
//
//  Created by Uri on 5/9/24.
//

import Foundation

enum UseCaseError: Error {
    case networkError
    case decodingError
    case undefinedError
    
    var errorDescription: String {
        switch self {
        case .networkError:
            return "There was a problem connecting to the network. Please check your internet connection."
        case .decodingError:
            return "There was an issue decoding the response. Please try again later."
        case .undefinedError:
            return "An unexpected error occurred. Please try again."
        }
    }
}
