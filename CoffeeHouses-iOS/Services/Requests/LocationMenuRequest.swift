//
//  LocationMenuRequest.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 22.12.2023.
//

import Foundation

struct LocationMenuRequest: NetworkRequest {
    let locationId: Int
    let token: String
    
    var endpoint: URL? {
        URL(string: "\(ApiConstants.baseURL)/location/\(locationId)/menu")
    }
    
    var authToken: String? {
        token
    }
    
    var authTokenHeader: String? {
        ApiConstants.authTokenHeader
    }
}
