//
//  AuthTokenStorage.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 22.12.2023.
//

import Foundation
import KeychainSwift

protocol AuthTokenStorage {
    var token: String? { get }
    func setToken(_ token: String)
}

final class AuthTokenStorageImpl: AuthTokenStorage {
    private let keychain = KeychainSwift()
    
    var token: String? {
        keychain.get(KeychainConstants.authTokenKey)
    }
    
    func setToken(_ token: String) {
        keychain.set(token, forKey: KeychainConstants.authTokenKey)
    }
}
