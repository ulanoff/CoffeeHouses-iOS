// 
//  CafesListViewController.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 24.12.2023.
//

import UIKit
import SnapKit

protocol CafesListViewProtocol: AnyObject {
    func showError(error: Error)
    func showCafes()
    func showLoader()
    func hideLoader()
}

final class CafesListViewController: UIViewController {
    
    var presenter: CafesListPresenterProtocol?
    
    // MARK: - UI Elements

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CafeTableCell.self, forCellReuseIdentifier: CafeTableCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var mapButton: CHButton = {
        let button = CHButton()
        button.setTitle("cafesList-showOnMapButton"~, for: .normal)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 12
        
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(mapButton)
        return stackView
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
}

// MARK: - Private Methods

private extension CafesListViewController {
    
    func showAlert(title: String?, message: String?) {
        guard title != nil || message != nil else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "alert-ok"~, style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    // MARK: - Setup UI

    func setupUI() {
        // Subviews
        view.addSubview(stackView)
        
        // Constraints
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        mapButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(19)
            make.trailing.equalToSuperview().offset(-19)
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        
        // Views Configuration
        title = "cafesList-title"~
        view.backgroundColor = .chWhite
    }
}

// MARK: - CafesListViewProtocol

extension CafesListViewController: CafesListViewProtocol {
    func showError(error: Error) {
        showAlert(title: nil, message: error.localizedDescription)
    }
    
    func showCafes() {
        tableView.reloadData()
    }
    
    func showLoader() {
        UIBlockingProgressHUD.show()
    }
    
    func hideLoader() {
        UIBlockingProgressHUD.dismiss()
    }
}

// MARK: - UITableViewDataSource

extension CafesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.cafes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter,
              let cell = tableView.dequeueReusableCell(withIdentifier: CafeTableCell.reuseIdentifier) as? CafeTableCell
        else {
            assertionFailure("Failed to cast dequed cell to CafeTableCell class")
            return UITableViewCell()
        }
        let cafe = presenter.cafes[indexPath.row]
        cell.configure(with: cafe)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

// MARK: - UITableViewDelegate

extension CafesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
