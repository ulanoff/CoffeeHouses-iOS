// 
//  CafesMapRouter.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

import UIKit

protocol CafesMapRouterProtocol {
    func goToCafeMenu(cafeId: Int)
}

final class CafesMapRouter: CafesMapRouterProtocol {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
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
}
