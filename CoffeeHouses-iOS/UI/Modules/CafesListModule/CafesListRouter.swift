// 
//  CafesListRouter.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 24.12.2023.
//

import UIKit

protocol CafesListRouterProtocol {
    var navigationController: UINavigationController? { get }
    func showAuth()
    func goToMap(cafes: [CoffeeLocation])
    func goToCafeMenu(cafeId: Int)
}

final class CafesListRouter: CafesListRouterProtocol {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.popViewController(animated: false)
    }
    
    func goToMap(cafes: [CoffeeLocation]) {
        guard let navigationController else {
            assertionFailure()
            return
        }
        let mapModule = CafesMapModuleBuilder.build(cafes: cafes, nc: navigationController)
        navigationController.pushViewController(mapModule, animated: true)
    }
    
    func goToCafeMenu(cafeId: Int) {
        guard let navigationController,
              let token = AuthTokenStorageImpl().token else {
            assertionFailure()
            return
        }
        let module = CafeMenuModuleBuilder.build(cafeId: cafeId, authToken: token, nc: navigationController)
        navigationController.pushViewController(module, animated: true)
    }
    
    func showAuth() {
        guard let navigationController else {
            assertionFailure()
            return
        }
        let authModule = SignInModuleBuilder.build(nc: navigationController)
        navigationController.viewControllers = [authModule]
    }
}
