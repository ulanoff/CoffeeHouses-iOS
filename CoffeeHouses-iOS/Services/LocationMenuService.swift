//
//  LocationMenuService.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 22.12.2023.
//

import Foundation

typealias LocationMenuCompletion = (Result<CoffeeLocationMenu, Error>) -> Void

protocol LocationMenuService {
    func loadLocation(id: Int, completion: @escaping LocationMenuCompletion)
}

final class LocationMenuServiceImpl: LocationMenuService {
    private let networkClient: NetworkClient
    private let token: String
    
    init(networkClient: NetworkClient, token: String) {
        self.networkClient = networkClient
        self.token = token
    }
    
    func loadLocation(id: Int, completion: @escaping LocationMenuCompletion) {
        let request = LocationMenuRequest(locationId: id, token: token)
        networkClient.send(request: request, type: CoffeeLocationMenu.self) { result in
            switch result {
            case .success(let menu):
                completion(.success(menu))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
