//
//  NewUserCredentials.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 24.12.2023.
//

import Foundation

struct NewUserCredentials {
    var login: String
    var password: String
    var repeatedPassword: String
    
    init(email: String, password: String, repeatedPassword: String) {
        self.login = email
        self.password = password
        self.repeatedPassword = repeatedPassword
    }
    
    init() {
        login = ""
        password = ""
        repeatedPassword = ""
    }
    
    var isValid: Bool {
        !(login.isEmpty && password.isEmpty) &&
        password == repeatedPassword
    }
}
