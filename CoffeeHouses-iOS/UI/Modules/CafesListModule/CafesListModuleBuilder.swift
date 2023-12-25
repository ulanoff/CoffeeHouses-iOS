// 
//  CafesListModuleBuilder.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 24.12.2023.
//

import UIKit

final class CafesListModuleBuilder {
    static func build(authToken: String, nc: UINavigationController) -> CafesListViewController {
        let networkClient = DefaultNetworkClient()
        let converter = CafesListCafeConverter()
        let locationsService = LocationsServiceImpl(networkClient: networkClient, token: authToken)
        let interactor = CafesListInteractor(locationsService: locationsService)
        let router = CafesListRouter(navigationController: nc)
        let presenter = CafesListPresenter(interactor: interactor, router: router, cafeConverter: converter)
        let viewController = CafesListViewController()
        converter.presenter = presenter
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
    }
}
