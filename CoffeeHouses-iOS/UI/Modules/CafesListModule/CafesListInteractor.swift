// 
//  CafesListInteractor.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 24.12.2023.
//

protocol CafesListInteractorProtocol: AnyObject {
    func loadCafes()
}

final class CafesListInteractor: CafesListInteractorProtocol {
    weak var presenter: CafesListPresenterProtocol?
    private let locationsService: LocationsService
    
    init(locationsService: LocationsService) {
        self.locationsService = locationsService
    }
    
    func loadCafes() {
        locationsService.loadLocations { [weak self] result in
            switch result {
            case .success(let cafes):
                self?.presenter?.cafesLoaded(locations: cafes)
            case .failure(let error):
                self?.presenter?.cafesLoadingError(error: error)
            }
        }
    }
}
