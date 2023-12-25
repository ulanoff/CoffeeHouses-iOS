//
//  SignUpError.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 24.12.2023.
//

import Foundation

enum SignUpError: Error, LocalizedError {
    case unknownError
    case accountAlreadyExists
    case passwordsDoesntMatch
    
    var errorDescription: String? {
        switch self {
        case .unknownError:
            "error-unknown"~
        case .accountAlreadyExists:
            "error-accountAlreadyExists"~
        case .passwordsDoesntMatch:
            "error-passwordsDoesntMatch"~
        }
    }
}
