//
//  CafeMenuCollectionCell.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

import UIKit
import Kingfisher

protocol CafeMenuCollectionCellDelegate: AnyObject {
    func cafeMenuCollectionCell(_ cell: CafeMenuCollectionCell, menuItemDidChange menuItem: MenuItem)
}

final class CafeMenuCollectionCell: UICollectionViewCell {
    static let reuseIdentifier = "CafeMenuCollectionCell"
    weak var delegate: CafeMenuCollectionCellDelegate?
    var menuItem: MenuItem!
    
    // MARK: - UI Elements
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .chBrownLight
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .chBrown
        label.font = .systemFont(ofSize: 14, weight: .bold)
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
        button.tintColor = .chBrownUltraLight
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(.plusButton, for: .normal)
        button.tintColor = .chBrownUltraLight
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var quantityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var quantityAndPriceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    // MARK: - Public Methods
    
    func configure(with menuItem: MenuItem) {
        self.menuItem = menuItem
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: menuItem.imageURL)
        itemNameLabel.text = menuItem.name
        priceLabel.text = "\(menuItem.price) \("currency-russianRouble-short"~)"
        quantityLabel.text = menuItem.quantity.description
    }

}

// MARK: - Event Handling

@objc
private extension CafeMenuCollectionCell {
    func minusButtonTapped() {
        menuItem.decrement()
        quantityLabel.text = menuItem.quantity.description
        delegate?.cafeMenuCollectionCell(self, menuItemDidChange: menuItem)
    }
    
    func plusButtonTapped() {
        menuItem.increment()
        quantityLabel.text = menuItem.quantity.description
        delegate?.cafeMenuCollectionCell(self, menuItemDidChange: menuItem)
    }
}

// MARK: - Private Methods

private extension CafeMenuCollectionCell {
    
    func setupUI() {
        // Subviews
        addSubview(imageView)
        addSubview(itemNameLabel)
        addSubview(priceLabel)
        addSubview(quantityAndPriceStackView)
        quantityAndPriceStackView.addArrangedSubview(priceLabel)
        quantityAndPriceStackView.addArrangedSubview(quantityStackView)
        quantityStackView.addArrangedSubview(minusButton)
        quantityStackView.addArrangedSubview(quantityLabel)
        quantityStackView.addArrangedSubview(plusButton)
        
        // Constraints
        imageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(137)
        }
        itemNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(11)
            make.trailing.equalToSuperview().offset(-11)
        }
        quantityAndPriceStackView.snp.makeConstraints { make in
            make.top.equalTo(itemNameLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(11)
            make.trailing.equalToSuperview().offset(-7)
            make.bottom.equalToSuperview().offset(-11)
        }
        
        // Views Configuration
        backgroundColor = .chWhite
    }
    
}
