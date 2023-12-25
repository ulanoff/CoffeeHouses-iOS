//
//  CafeMenuError.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

import Foundation

enum CafeMenuError: Error, LocalizedError {
    case unknownError
    case unauthorized
    case emptyOrder
    
    var errorDescription: String? {
        switch self {
        case .unknownError:
            "error-unknown"~
        case .unauthorized:
            "error-unauthorized"~
        case .emptyOrder:
            "error-emptyOrder"~
        }
    }
}
