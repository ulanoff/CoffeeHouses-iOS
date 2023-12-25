//
//  CafesMapConverter.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

import Foundation

protocol CafesMapConverterProtocol: AnyObject {
    func convertToCafePlacemarks(coffeeLocations: [CoffeeLocation]) -> [CafePlacemark]
}

final class CafesMapConverter: CafesMapConverterProtocol {
    func convertToCafePlacemarks(coffeeLocations: [CoffeeLocation]) -> [CafePlacemark] {
        coffeeLocations.compactMap { cafe in
            guard let location = Location(mapPoint: cafe.point) else { return nil }
            return CafePlacemark(cafeId: cafe.id, name: cafe.name, location: location)
        }
    }
}
