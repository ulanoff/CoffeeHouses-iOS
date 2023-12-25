// 
//  CafesMapPresenter.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

protocol CafesMapPresenterProtocol: AnyObject {
    var cafePlacemarks: [CafePlacemark] { get }
    func viewDidLoad()
}

final class CafesMapPresenter {
    weak var view: CafesMapViewProtocol?
    var router: CafesMapRouterProtocol
    var converter: CafesMapConverterProtocol
    
    let cafes: [CoffeeLocation]
    var cafePlacemarks: [CafePlacemark] = []

    init(router: CafesMapRouterProtocol, converter: CafesMapConverterProtocol, cafes: [CoffeeLocation]) {
        self.router = router
        self.cafes = cafes
        self.converter = converter
    }
}

extension CafesMapPresenter: CafesMapPresenterProtocol {
    func viewDidLoad() {
        cafePlacemarks = converter.convertToCafePlacemarks(coffeeLocations: cafes)
        view?.showPlacemarks(cafePlacemarks)
    }
}
