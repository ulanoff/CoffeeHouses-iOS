//
//  SignInError.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 24.12.2023.
//

import Foundation

enum SignInError: Error, LocalizedError {
    case wrongCredentials
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .wrongCredentials:
            "error-wrongCredentials"~
        case .unknownError:
            "error-unknown"~
        }
    }
}
