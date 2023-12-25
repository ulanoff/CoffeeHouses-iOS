//
//  CHTextFieldWithLabel.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 23.12.2023.
//

import UIKit
import SnapKit

final class CHTextFieldWithLabel: UIView {
    
    // MARK: - UI Elements

    lazy var textField = CHTextField()
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .chBrown
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 7.5
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        return stackView
    }()
    
    // MARK: - Initializer

    convenience init(labelText: String, placeholder: String) {
        self.init(frame: .zero)
        label.text = labelText
        textField.placeholder = placeholder
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CHTextFieldWithLabel {
    func setupUI() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
