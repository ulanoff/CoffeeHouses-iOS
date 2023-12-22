//
//  TestViewController.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 22.12.2023.
//

import UIKit

final class TestViewController: UIViewController {
    private let authService: AuthService = AuthServiceImpl(networkClient: DefaultNetworkClient())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}
