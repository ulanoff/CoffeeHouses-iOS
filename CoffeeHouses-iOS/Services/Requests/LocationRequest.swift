//
//  LocationRequest.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 22.12.2023.
//

import Foundation

struct LocationRequest: NetworkRequest {
    let token: String
    
    var endpoint: URL? {
        URL(string: "\(ApiConstants.baseURL)/locations")
    }
    
    var authToken: String? {
        token
    }
    
    var authTokenHeader: String? {
        ApiConstants.authTokenHeader
    }
}
