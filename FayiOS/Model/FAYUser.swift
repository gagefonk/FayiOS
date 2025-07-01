//  FAYUser.swift
//  FayiOS

import Foundation

struct FayUser: Hashable {
    let userName: String
    var token: String?
}

enum UserFetchError: Error, LocalizedError {
    case networkError
    case empty
    case invalidCredentials
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "A network error occured"
        case .empty:
            return "Missing email or password"
        case .invalidCredentials:
            return "Invalid email or password"
        }
    }
}
