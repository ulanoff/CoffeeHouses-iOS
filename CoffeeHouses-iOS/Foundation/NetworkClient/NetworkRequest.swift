//
//  NetworkRequest.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 22.12.2023.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkRequest {
    var endpoint: URL? { get }
    var httpMethod: HttpMethod { get }
    var dto: [String: Any]? { get }
    var authToken: String? { get }
    var authTokenHeader: String? { get }
}

// default values
extension NetworkRequest {
    var httpMethod: HttpMethod { .get }
    var dto: [String: Any]? { nil }
    var authToken: String? { nil }
    var authTokenHeader: String? { nil }
}

