//
//  NSLocalizedStringPostfixOperator.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 23.12.2023.
//

import Foundation

postfix operator ~
postfix func ~ (string: String) -> String {
    return NSLocalizedString(string, comment: "")
}
