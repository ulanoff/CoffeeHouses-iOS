//
//  Credentials.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 22.12.2023.
//

struct Credentials {
    var login: String
    var password: String
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
    
    init() {
        login = ""
        password = ""
    }
    
    var isValid: Bool {
        !(login.isEmpty && password.isEmpty)
    }
}
