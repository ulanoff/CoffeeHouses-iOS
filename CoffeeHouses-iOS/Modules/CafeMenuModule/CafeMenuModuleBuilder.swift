// 
//  CafeMenuModuleBuilder.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

import UIKit

final class CafeMenuModuleBuilder {
    static func build(cafeId: Int, authToken: String, nc: UINavigationController) -> CafeMenuViewController {
        let networkClient = DefaultNetworkClient()
        let locationMenuService = LocationMenuServiceImpl(networkClient: networkClient, token: authToken)
        let interactor = CafeMenuInteractor(cafeMenuService: locationMenuService)
        let router = CafeMenuRouter(navigationController: nc)
        let presenter = CafeMenuPresenter(cafeId: cafeId, interactor: interactor, router: router)
        let viewController = CafeMenuViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}
