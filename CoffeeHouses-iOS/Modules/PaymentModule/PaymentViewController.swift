// 
//  PaymentViewController.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

import UIKit

protocol PaymentViewProtocol: AnyObject {
}

final class PaymentViewController: UIViewController {
    
    var presenter: PaymentPresenterProtocol?
    
    // MARK: - UI Elements

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(OrderTableCell.self, forCellReuseIdentifier: OrderTableCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var payButton: CHButton = {
        let button = CHButton()
        button.setTitle("payment-payButton"~, for: .normal)
        return button
    }()
    
    private lazy var messageForUserLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .chBrown
        label.text = "payment-msgForUser"~
        return label
    }()
    
    private lazy var tableAndMessageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Private Methods

private extension PaymentViewController {
    
    // MARK: - Setup UI

    func setupUI() {
        // Subviews
        tableAndMessageStackView.addArrangedSubview(tableView)
        tableAndMessageStackView.addArrangedSubview(messageForUserLabel)
        stackView.addArrangedSubview(tableAndMessageStackView)
        stackView.addArrangedSubview(payButton)
        view.addSubview(stackView)
        
        // Constraints
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-12)
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        
        // Views Configuration
        title = "payment-title"~
        view.backgroundColor = .chWhite
    }
}

// MARK: - PaymentViewProtocol

extension PaymentViewController: PaymentViewProtocol {
}

// MARK: - UITableViewDataSource

extension PaymentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.order.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter,
              let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableCell.reuseIdentifier) as? OrderTableCell
        else {
            assertionFailure("Failed to cast dequed cell to CafeTableCell class")
            return UITableViewCell()
        }
        cell.configure(with: presenter.order[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

// MARK: - UITableViewDelegate

extension PaymentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
