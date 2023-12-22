//
//  SignUpRequest.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 22.12.2023.
//

import Foundation

struct SignUpRequest: NetworkRequest {
    let login: String
    let password: String
    
    var endpoint: URL? {
        URL(string: "\(ApiConstants.baseURL)/auth/register")
    }
    
    var httpMethod: HttpMethod {
        .post
    }
    
    var dto: [String : Any]? {
        [
            "login": login,
            "password": password
        ]
    }
}
