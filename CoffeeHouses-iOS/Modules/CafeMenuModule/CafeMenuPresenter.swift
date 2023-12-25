// 
//  CafeMenuPresenter.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

protocol CafeMenuPresenterProtocol: AnyObject, CafeMenuCollectionCellDelegate {
    var menuItems: [MenuItem] { get }
    func viewDidLoad()
    func menuLoaded(menu: CoffeeLocationMenu)
    func menuLoadingError(error: Error)
    func paymentButtonTapped()
}

final class CafeMenuPresenter {
    weak var view: CafeMenuViewProtocol?
    var router: CafeMenuRouterProtocol
    var interactor: CafeMenuInteractorProtocol
    
    var cafeId: Int
    var menuItems: [MenuItem] = []

    init(cafeId: Int, interactor: CafeMenuInteractorProtocol, router: CafeMenuRouterProtocol) {
        self.interactor = interactor
        self.router = router
        self.cafeId = cafeId
    }
}

extension CafeMenuPresenter: CafeMenuPresenterProtocol {
    func viewDidLoad() {
        view?.showLoader()
        interactor.loadMenu(for: cafeId)
    }
    
    func paymentButtonTapped() {
        let order = menuItems.filter { $0.quantity > 0 }
        if order.count > 0 {
            router.goToPayment(order: order)
        } else {
            view?.showError(error: CafeMenuError.emptyOrder)
        }
    }
    
    func menuLoaded(menu: CoffeeLocationMenu) {
        view?.hideLoader()
        menuItems = menu.compactMap { MenuItem(coffeeLocationMenuItem: $0) }
        view?.showData()
    }
    
    func menuLoadingError(error: Error) {
        view?.hideLoader()
        if let error = error as? NetworkClientError {
            switch error {
            case .httpStatusCode(let code):
                if code == 401 {
                    view?.showError(error: CafeMenuError.unauthorized)
                } else {
                    view?.showError(error: CafeMenuError.unknownError)
                }
            default:
                view?.showError(error: CafeMenuError.unknownError)
            }
        } else {
            view?.showError(error: CafeMenuError.unknownError)
        }
        
    }
}

// MARK: - CafeMenuCollectionCellDelegate

extension CafeMenuPresenter {
    func cafeMenuCollectionCell(_ cell: CafeMenuCollectionCell, menuItemDidChange menuItem: MenuItem) {
        menuItems = menuItems.map { item in
            if item == menuItem {
                return menuItem
            } else {
                return item
            }
        }
    }
}
