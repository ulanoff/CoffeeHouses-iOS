//
//  OrderTableCell.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

import UIKit
import SnapKit

final class OrderTableCell: UITableViewCell {
    static let reuseIdentifier = "OrderTableCell"
    
    // MARK: - UI Elements
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .chBrown
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .chBrownLight
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .chBrown
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(.minusButton, for: .normal)
        button.tintColor = .chBrown
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(.plusButton, for: .normal)
        button.tintColor = .chBrown
        return button
    }()
    
    private lazy var quantityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var nameAndPriceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 6
        return stackView
    }()
    
    private lazy var leftAndRightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .chBrownUltraLight
        view.layer.cornerRadius = 5
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: 5).cgPath
        containerView.layer.shadowColor = UIColor.chBlack.withAlphaComponent(0.25).cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    // MARK: - Public Methods

    func configure(with menuItem: MenuItem) {
        nameLabel.text = menuItem.name
        priceLabel.text = "\(menuItem.price) \("currency-russianRouble-short"~)"
        quantityLabel.text = menuItem.quantity.description
    }
}

// MARK: - Private Methods

private extension OrderTableCell {
    
    // MARK: - Setup UI

    func setupUI() {
        // Subviews
        addSubview(containerView)
        nameAndPriceStackView.addArrangedSubview(nameLabel)
        nameAndPriceStackView.addArrangedSubview(priceLabel)
        quantityStackView.addArrangedSubview(minusButton)
        quantityStackView.addArrangedSubview(quantityLabel)
        quantityStackView.addArrangedSubview(plusButton)
        leftAndRightStackView.addArrangedSubview(nameAndPriceStackView)
        leftAndRightStackView.addArrangedSubview(quantityStackView)
        containerView.addSubview(leftAndRightStackView)
        
        // Constraints
        containerView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(71)
        }
        
        leftAndRightStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(14)
            make.bottom.equalToSuperview().offset(-9)
        }
        
        // Views Configuration
        selectionStyle = .none
    }
}
