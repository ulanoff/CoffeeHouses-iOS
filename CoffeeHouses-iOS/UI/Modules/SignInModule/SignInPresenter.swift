//
//  SignInPresenter.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 23.12.2023.
//

protocol SignInPresenterProtocol: AnyObject {
    func loginChanged(login: String)
    func passwordChanged(password: String)
    func signInButtonTapped()
    func authTokenRecieved(token: String)
    func authError(error: Error)
}

final class SignInPresenter {
    weak var view: SignInViewProtocol?
    var router: SignInRouterProtocol
    var interactor: SignInInteractorProtocol
    private let tokenStorage: AuthTokenStorage
    
    private var credentials = Credentials()

    init(interactor: SignInInteractorProtocol, router: SignInRouterProtocol, authTokenStorage: AuthTokenStorage) {
        self.interactor = interactor
        self.router = router
        self.tokenStorage = authTokenStorage
    }
}

extension SignInPresenter: SignInPresenterProtocol {
    func loginChanged(login: String) {
        credentials.login = login
    }
    
    func passwordChanged(password: String) {
        credentials.password = password
    }
    
    func signInButtonTapped() {
        if credentials.isValid {
            view?.showLoader()
            interactor.auth(with: credentials)
        }
    }
    
    func authTokenRecieved(token: String) {
        tokenStorage.setToken(token)
        view?.hideLoader()
        view?.showSuccess()
    }
    
    func authError(error: Error) {
        view?.hideLoader()
        if let error = error as? NetworkClientError {
            switch error {
            case .httpStatusCode(let code):
                if code == 401 {
                    view?.showError(error: .wrongCredentials)
                } else {
                    view?.showError(error: .unknownError)
                }
            default:
                view?.showError(error: .unknownError)
            }
        } else {
            view?.showError(error: .unknownError)
        }
    }
}
