//
//  CafesListError.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

import Foundation

enum CafesListError: Error, LocalizedError {
    case unknownError
    case unauthorized
    
    var errorDescription: String? {
        switch self {
        case .unknownError:
            "error-unknown"~
        case .unauthorized:
            "error-unauthorized"~
        }
    }
}
