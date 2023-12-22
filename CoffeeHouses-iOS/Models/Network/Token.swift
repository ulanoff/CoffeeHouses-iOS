//
//  Token.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 22.12.2023.
//

import Foundation

struct Token: Decodable {
    let token: String
    let tokenLifetime: Int
}
