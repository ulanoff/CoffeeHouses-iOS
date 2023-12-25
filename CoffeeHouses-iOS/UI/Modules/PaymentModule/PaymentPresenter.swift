// 
//  PaymentPresenter.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

protocol PaymentPresenterProtocol: AnyObject {
    var order: [MenuItem] { get }
}

final class PaymentPresenter {
    weak var view: PaymentViewProtocol?
    var router: PaymentRouterProtocol
    
    var order: [MenuItem]

    init(order: [MenuItem], router: PaymentRouterProtocol) {
        self.router = router
        self.order = order
    }
}

extension PaymentPresenter: PaymentPresenterProtocol {
}
