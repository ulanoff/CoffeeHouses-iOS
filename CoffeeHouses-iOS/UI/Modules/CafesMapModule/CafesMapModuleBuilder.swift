// 
//  CafesMapModuleBuilder.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

import UIKit

final class CafesMapModuleBuilder {
    static func build(cafes: [CoffeeLocation]) -> CafesMapViewController {
        let converter = CafesMapConverter()
        let router = CafesMapRouter()
        let presenter = CafesMapPresenter(router: router, converter: converter, cafes: cafes)
        let viewController = CafesMapViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
