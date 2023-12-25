// 
//  PaymentModuleBuilder.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

import UIKit

final class PaymentModuleBuilder {
    static func build(order: [MenuItem]) -> PaymentViewController {
        let router = PaymentRouter()
        let presenter = PaymentPresenter(order: order, router: router)
        let viewController = PaymentViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
