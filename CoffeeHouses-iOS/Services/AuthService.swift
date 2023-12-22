//
//  AuthService.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 22.12.2023.
//

import Foundation

typealias AuthCompletion = (Result<Token, Error>) -> Void

protocol AuthService {
    func signInWith(credentials: Credentials, completion: @escaping AuthCompletion)
    func signUpWith(credentials: Credentials, completion: @escaping AuthCompletion)
}

final class AuthServiceImpl: AuthService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func signInWith(credentials: Credentials, completion: @escaping AuthCompletion) {
        let request = SignInRequest(login: credentials.login,
                                    password: credentials.password)
        networkClient.send(request: request, type: Token.self) { result in
            switch result {
            case .success(let token):
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func signUpWith(credentials: Credentials, completion: @escaping AuthCompletion) {
        let request = SignUpRequest(login: credentials.login,
                                    password: credentials.password)
        networkClient.send(request: request, type: Token.self) { result in
            switch result {
            case .success(let token):
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
