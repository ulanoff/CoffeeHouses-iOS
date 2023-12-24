//
//  SignInInteractor.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 23.12.2023.
//

protocol SignInInteractorProtocol: AnyObject {
    func auth(with credentials: Credentials)
}

final class SignInInteractor: SignInInteractorProtocol {
    weak var presenter: SignInPresenterProtocol?
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func auth(with credentials: Credentials) {
        authService.signInWith(credentials: credentials) { [weak self] result in
            switch result {
            case .success(let token):
                self?.presenter?.authTokenRecieved(token: token.token)
            case .failure(let error):
                self?.presenter?.authError(error: error)
            }
        }
    }
}
