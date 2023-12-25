// 
//  SignUpRouter.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 24.12.2023.
//

import UIKit

protocol SignUpRouterProtocol {
    func showMain(token: String)
}

final class SignUpRouter: SignUpRouterProtocol {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showMain(token: String) {
        guard let navigationController else {
            assertionFailure()
            return
        }
        let cafesListModule = CafesListModuleBuilder.build(authToken: token, nc: navigationController)
        navigationController.setViewControllers([cafesListModule], animated: true)
    }
}
