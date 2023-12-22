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
    private let token: String
    
    init(networkClient: NetworkClient, token: String) {
        self.networkClient = networkClient
        self.token = token
    }
    
    func loadLocations(completion: @escaping LocationsCompletion) {
        let request = LocationRequest(token: token)
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
