// 
//  SignUpInteractor.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 24.12.2023.
//

protocol SignUpInteractorProtocol: AnyObject {
    func signUp(with credentials: Credentials)
}

final class SignUpInteractor: SignUpInteractorProtocol {
    weak var presenter: SignUpPresenterProtocol?
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func signUp(with credentials: Credentials) {
        authService.signUpWith(credentials: credentials) { [weak self] result in
            switch result {
            case .success(let token):
                self?.presenter?.authTokenRecieved(token: token.token)
            case .failure(let error):
                self?.presenter?.authError(error: error)
            }
        }
    }
}
