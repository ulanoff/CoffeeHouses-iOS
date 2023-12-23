//
//  CHTextField.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 23.12.2023.
//

import UIKit

final class CHTextField: UITextField {
    private let textPadding = UIEdgeInsets(
        top: 13,
        left: 18,
        bottom: 13.5,
        right: 20
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}

// MARK: - Private Methods

private extension CHTextField {
    
    // MARK: - Setup UI
    
    func setupUI() {
        textColor = .chBrownLight
        font = .systemFont(ofSize: 18)
        borderStyle = .none
        layer.borderColor = UIColor.chBrown.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 24.5
        attributedPlaceholder = NSAttributedString(
            string: "placeholder",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.chBrownLight]
        )
    }
}
