//
//  LocationsService.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 22.12.2023.
//

import Foundation

typealias LocationsCompletion = (Result<[CoffeeLocation], Error>) -> Void

protocol LocationsService {
    func loadLocations(completion: @escaping LocationsCompletion)
}

final class LocationsServiceImpl: LocationsService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadLocations(completion: @escaping LocationsCompletion) {
        // TODO: - Replace with real token
        let testToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBdXRoZW50aWNhdGlvbiIsImlzcyI6ImNvZmZlZSBiYWNrZW5kIiwiaWQiOjEyOSwiZXhwIjoxNzAzMjY3MjYwfQ.5nMKWel13QwAJj8DB3orPZSvGwL23WEE0FHav3U_u6w"
        let request = LocationRequest(token: testToken)
        networkClient.send(request: request, type: [CoffeeLocation].self) { result in
            switch result {
            case .success(let location):
                completion(.success(location))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
