//
//  MenuItem.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

import Foundation

struct MenuItem: Equatable {
    let id: Int
    let name: String
    let price: Int
    let imageURL: URL
    var quantity: Int
    
    init(id: Int, name: String, price: Int, imageURL: URL, quantity: Int = 0) {
        self.id = id
        self.name = name
        self.price = price
        self.imageURL = imageURL
        self.quantity = quantity
    }
    
    init?(coffeeLocationMenuItem: CoffeeLocationMenuItem, quantity: Int = 0) {
        guard let url = URL(string: coffeeLocationMenuItem.imageURL) else {
            return nil
        }
        self.id = coffeeLocationMenuItem.id
        self.name = coffeeLocationMenuItem.name
        self.price = coffeeLocationMenuItem.price
        self.imageURL = url
        self.quantity = quantity
    }
    
    mutating func increment() {
        quantity += 1
    }
    
    mutating func decrement() {
        if quantity > 0 {
            quantity -= 1
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
