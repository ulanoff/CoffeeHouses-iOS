//
//  SignInModuleBuilder.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 23.12.2023.
//

import UIKit

final class SignInModuleBuilder {
    static func build() -> SignInViewController {
        let networkClient = DefaultNetworkClient()
        let authService = AuthServiceImpl(networkClient: networkClient)
        let interactor = SignInInteractor(authService: authService)
        let tokenStorage = AuthTokenStorageImpl()
        let router = SignInRouter()
        let presenter = SignInPresenter(interactor: interactor, router: router, authTokenStorage: tokenStorage)
        let viewController = SignInViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
