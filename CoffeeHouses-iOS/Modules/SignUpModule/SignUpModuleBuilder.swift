// 
//  SignUpModuleBuilder.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 24.12.2023.
//

import UIKit

final class SignUpModuleBuilder {
    static func build(nc: UINavigationController) -> SignUpViewController {
        let networkClient = DefaultNetworkClient()
        let authService = AuthServiceImpl(networkClient: networkClient)
        let interactor = SignUpInteractor(authService: authService)
        let tokenStorage = AuthTokenStorageImpl()
        let router = SignUpRouter(navigationController: nc)
        let presenter = SignUpPresenter(interactor: interactor, router: router, tokenStorage: tokenStorage)
        let viewController = SignUpViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}
