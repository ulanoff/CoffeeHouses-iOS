//
//  CafeTableCell.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 24.12.2023.
//

import UIKit
import SnapKit

final class CafeTableCell: UITableViewCell {
    static let reuseIdentifier = "CafeTableCell"
    
    // MARK: - UI Elements
    
    private lazy var cafeNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .chBrown
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .chBrownLight
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 6
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

    func configure(with cafe: Cafe) {
        let distanceString = makeDistanceString(cafe.distance)
        let fromYouString = "cafesList-distancePostfix"~
        cafeNameLabel.text = cafe.name
        distanceLabel.text = "\(distanceString) \(fromYouString)"
    }
}

// MARK: - Private Methods

private extension CafeTableCell {
    
    func makeDistanceString(_ distanceInMeters: Double) -> String {
        if distanceInMeters < 1000 {
            return "\(Int(distanceInMeters)) \("unit-meter-short"~)"
        } else {
            let kilometers = distanceInMeters / 1000.0
            
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumFractionDigits = 0
            numberFormatter.maximumFractionDigits = distanceInMeters < 10_000 ? 2 : 1
            
            if let formattedString = numberFormatter.string(from: NSNumber(value: kilometers)) {
                return "\(formattedString) \("unit-kilometer-short"~)"
            } else {
                return "\(kilometers) \("unit-kilometer-short"~)"
            }
        }
    }

    
    // MARK: - Setup UI

    func setupUI() {
        // Subviews
        addSubview(containerView)
        stackView.addArrangedSubview(cafeNameLabel)
        stackView.addArrangedSubview(distanceLabel)
        containerView.addSubview(stackView)
        
        // Constraints
        containerView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(71)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(14)
            make.bottom.equalToSuperview().offset(-9)
        }
        
        // Views Configuration
        selectionStyle = .none
    }
}
