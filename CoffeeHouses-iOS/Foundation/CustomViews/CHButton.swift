//
//  CHButton.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 23.12.2023.
//

import UIKit

final class CHButton: UIButton {
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadows()
    }
    
    // MARK: - Overrides
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = 47
        return size
    }
}

// MARK: - Private Methods

private extension CHButton {
    
    // MARK: - Setup UI
    
    func setupUI() {
        let borderWidth: CGFloat = 2
        frame = CGRectInset(self.frame, -borderWidth, -borderWidth);
        titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        backgroundColor = .chBrownDark
        setTitleColor(.chBrownUltraLight, for: .normal)
        setTitleColor(.chBrownUltraLight.withAlphaComponent(0.3), for: .highlighted)
        layer.cornerRadius = 24.5
        layer.borderWidth = borderWidth
        layer.borderColor = UIColor.chButtonBorder.cgColor
    }
    
    func setupShadows() {
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 24.5).cgPath
        layer.shadowColor = UIColor.chBlack.withAlphaComponent(0.2).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
}
