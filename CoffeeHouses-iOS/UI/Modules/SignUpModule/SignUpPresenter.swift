// 
//  SignUpPresenter.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 24.12.2023.
//

protocol SignUpPresenterProtocol: AnyObject {
    func loginChanged(login: String)
    func passwordChanged(password: String)
    func repeatedPasswordChanged(password: String)
    func signUpButtonTapped()
    func authTokenRecieved(token: String)
    func authError(error: Error)
}

final class SignUpPresenter {
    weak var view: SignUpViewProtocol?
    var router: SignUpRouterProtocol
    var interactor: SignUpInteractorProtocol
    private let tokenStorage: AuthTokenStorage
    
    private var newUserCredentials = NewUserCredentials()

    init(interactor: SignUpInteractorProtocol, router: SignUpRouterProtocol, tokenStorage: AuthTokenStorage) {
        self.interactor = interactor
        self.router = router
        self.tokenStorage = tokenStorage
    }
}

extension SignUpPresenter: SignUpPresenterProtocol {
    func loginChanged(login: String) {
        newUserCredentials.login = login
    }
    
    func passwordChanged(password: String) {
        newUserCredentials.password = password
    }
    
    func repeatedPasswordChanged(password: String) {
        newUserCredentials.repeatedPassword = password
    }
    
    func signUpButtonTapped() {
        print(newUserCredentials)
        if newUserCredentials.isValid {
            view?.showLoader()
            let credentials = Credentials(
                login: newUserCredentials.login,
                password: newUserCredentials.password
            )
            interactor.signUp(with: credentials)
        } else {
            view?.showError(error: .passwordsDoesntMatch)
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
                if code == 406 {
                    view?.showError(error: .accountAlreadyExists)
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
