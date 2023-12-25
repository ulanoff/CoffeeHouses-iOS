//
//  SignInRouter.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 23.12.2023.
//

import UIKit

protocol SignInRouterProtocol {
    var navigationController: UINavigationController? { get }
    func goToSignUp()
    func showMain(token: String)
}

final class SignInRouter: SignInRouterProtocol {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func goToSignUp() {
        guard let navigationController else {
            assertionFailure()
            return
        }
        let signUpModule = SignUpModuleBuilder.build(nc: navigationController)
        navigationController.pushViewController(signUpModule, animated: true)
    }
    
    func showMain(token: String) {
        guard let navigationController else {
            assertionFailure()
            return
        }
        let cafesListModule = CafesListModuleBuilder.build(authToken: token, nc: navigationController)
        navigationController.viewControllers = [cafesListModule]
    }
}
