// 
//  CafesListPresenter.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 24.12.2023.
//

protocol CafesListPresenterProtocol: AnyObject {
    var cafes: [Cafe] { get }
    func viewDidLoad()
    func cafesLoaded(locations: [CoffeeLocation])
    func cafesLoadingError(error: Error)
    func convertertingCompleted(cafes: [Cafe])
    func convertertingCompletedWithLocationError(cafes: [Cafe], error: LocationError)
    func cafeCellTapped(cafeId: Int)
    func mapButtonTapped()
}

final class CafesListPresenter {
    weak var view: CafesListViewProtocol?
    var router: CafesListRouterProtocol
    var interactor: CafesListInteractorProtocol
    private let cafeConverter: CafesListCafeConverterProtocol
    
    private var coffeeLocations: [CoffeeLocation] = []
    var cafes: [Cafe] = []

    init(interactor: CafesListInteractorProtocol, router: CafesListRouterProtocol, cafeConverter: CafesListCafeConverterProtocol) {
        self.interactor = interactor
        self.router = router
        self.cafeConverter = cafeConverter
    }
}

extension CafesListPresenter: CafesListPresenterProtocol {
    func viewDidLoad() {
        view?.showLoader()
        interactor.loadCafes()
    }
    
    func convertertingCompleted(cafes: [Cafe]) {
        self.cafes = cafes
        view?.hideLoader()
        view?.showCafes()
    }
    
    func convertertingCompletedWithLocationError(cafes: [Cafe], error: LocationError) {
        self.cafes = cafes
        view?.hideLoader()
        view?.showError(error: error)
        view?.showCafes()
    }
    
    func cafesLoaded(locations: [CoffeeLocation]) {
        self.coffeeLocations = locations
        cafeConverter.convertCoffeeLocationsToCafeModels(coffeLocations: locations)
    }
    
    func cafesLoadingError(error: Error) {
        view?.hideLoader()
        if let error = error as? NetworkClientError {
            switch error {
            case .httpStatusCode(let code):
                if code == 401 {
                    router.showAuth()
                } else {
                    view?.showError(error: CafesListError.unknownError)
                }
            default:
                view?.showError(error: CafesListError.unknownError)
            }
        } else {
            view?.showError(error: CafesListError.unknownError)
        }
    }
    
    func mapButtonTapped() {
        router.goToMap(cafes: coffeeLocations)
    }
    
    
    func cafeCellTapped(cafeId: Int) {
        router.goToCafeMenu(cafeId: cafeId)
    }
}
