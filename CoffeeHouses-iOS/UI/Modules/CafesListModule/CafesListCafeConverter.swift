//
//  CafesListCafeConverter.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 24.12.2023.
//

import Foundation
import CoreLocation

protocol CafesListCafeConverterProtocol: AnyObject {
    func convertCoffeeLocationsToCafeModels(coffeLocations: [CoffeeLocation])
}

final class CafesListCafeConverter: NSObject, CafesListCafeConverterProtocol {
    weak var presenter: CafesListPresenterProtocol?
    private let userLocationService = UserLocationService.shared
    
    func convertCoffeeLocationsToCafeModels(coffeLocations: [CoffeeLocation]) {
        userLocationService.getUsersCurrentLocation { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let location):
                presenter?.convertertingCompleted(
                    cafes: coffeLocations.map{ coffeeLocation in
                        guard let cafeLatitudeDouble = Double(coffeeLocation.point.latitude),
                              let cafeLongitudeDouble = Double(coffeeLocation.point.longitude)
                        else {
                            fatalError()
                        }
                        let userLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
                        let cafeCoordinates = CLLocation(
                            latitude: CLLocationDegrees(cafeLatitudeDouble),
                            longitude: CLLocationDegrees(cafeLongitudeDouble)
                        )
                        let distance = userLocation.distance(from: cafeCoordinates)
                        return Cafe(name: coffeeLocation.name, distance: distance)
                    }
                )
            case .failure(let error):
                let cafes = coffeLocations.map { Cafe(name: $0.name, distance: 0) }
                presenter?.convertertingCompletedWithLocationError(cafes: cafes, error: error)
            }
        }
    }
}
