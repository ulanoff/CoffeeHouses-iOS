// 
//  CafeMenuInteractor.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

protocol CafeMenuInteractorProtocol: AnyObject {
    func loadMenu(for locationId: Int)
}

final class CafeMenuInteractor: CafeMenuInteractorProtocol {
    weak var presenter: CafeMenuPresenterProtocol?
    private let cafeMenuService: LocationMenuService
    
    init(cafeMenuService: LocationMenuService) {
        self.cafeMenuService = cafeMenuService
    }
    
    func loadMenu(for locationId: Int) {
        cafeMenuService.loadLocation(id: locationId) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let menu):
                presenter?.menuLoaded(menu: menu)
            case .failure(let error):
                presenter?.menuLoadingError(error: error)
            }
        }
    }
}
