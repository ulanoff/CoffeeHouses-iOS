//
//  CoffeeLocation.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 22.12.2023.
//

import Foundation

struct CoffeeLocation: Decodable {
    let id: Int
    let name: String
    let point: MapPoint
}
