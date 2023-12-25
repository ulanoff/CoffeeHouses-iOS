// 
//  CafeMenuRouter.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

import UIKit

protocol CafeMenuRouterProtocol {
    func goToPayment(order: [MenuItem])
}

final class CafeMenuRouter: CafeMenuRouterProtocol {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func goToPayment(order: [MenuItem]) {
        let module = PaymentModuleBuilder.build(order: order)
        navigationController?.pushViewController(module, animated: true)
    }
}
