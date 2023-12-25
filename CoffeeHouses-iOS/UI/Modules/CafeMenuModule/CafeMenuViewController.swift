// 
//  CafeMenuViewController.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

import UIKit
import SnapKit

protocol CafeMenuViewProtocol: AnyObject {
    func showData()
    func showLoader()
    func hideLoader()
    func showError(error: Error)
}

private struct CollectionViewSettings {
    static let insets = UIEdgeInsets(top: 17, left: 16, bottom: 0, right: 16)
    static let interitemSpacing: CGFloat = 13
    static let lineSpacing: CGFloat = 13
    static let itemsPerLine: CGFloat = 2
    static let cellHeight: CGFloat = 205
}

final class CafeMenuViewController: UIViewController {
    
    var presenter: CafeMenuPresenterProtocol?
    
    // MARK: - UI Elements
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CafeMenuCollectionCell.self, forCellWithReuseIdentifier: CafeMenuCollectionCell.reuseIdentifier)
        collectionView.contentInset = CollectionViewSettings.insets
        return collectionView
    }()
    
    private lazy var paymentButton: CHButton = {
        let button = CHButton()
        button.setTitle("cafeMenu-paymentButton"~, for: .normal)
        button.addTarget(self, action: #selector(paymentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 12
        return stackView
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
    }
}

// MARK: - Event Handlers

@objc
private extension CafeMenuViewController {
    func paymentButtonTapped() {
        presenter?.paymentButtonTapped()
    }
}

// MARK: - Private Methods

private extension CafeMenuViewController {
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
        stackView.addArrangedSubview(collectionView)
        stackView.addArrangedSubview(paymentButton)
        
        // Constraints
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        paymentButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(19)
            make.trailing.equalToSuperview().offset(-19)
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        // Views Configuration
        title = "cafeMenu-title"~
        view.backgroundColor = .chWhite
    }
    
    func calculateColectionViewCellSize(collectionView: UICollectionView) -> CGSize {
        let interitemSpacing = CollectionViewSettings.interitemSpacing
        let itemsPerLine = CollectionViewSettings.itemsPerLine
        let insets = CollectionViewSettings.insets.left + CollectionViewSettings.insets.right
        let space = collectionView.frame.width
        let availableSpace = space - ((itemsPerLine - 1) * interitemSpacing) - insets
        let width = Int(availableSpace / itemsPerLine)
        return CGSize(
            width: Double(width),
            height: Double(CollectionViewSettings.cellHeight)
        )
    }
}

// MARK: - CafeMenuViewProtocol

extension CafeMenuViewController: CafeMenuViewProtocol {
    func showData() {
        collectionView.reloadData()
    }
    
    func showError(error: Error) {
        showAlert(title: nil, message: error.localizedDescription)
    }
    
    func showLoader() {
        UIBlockingProgressHUD.show()
    }
    
    func hideLoader() {
        UIBlockingProgressHUD.dismiss()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CafeMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter else { return 0 }
        return presenter.menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter,
              let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CafeMenuCollectionCell.reuseIdentifier,
            for: indexPath
        ) as? CafeMenuCollectionCell else {
            assertionFailure("Failed to cast dequed cell to CafeMenuCollectionCell class")
            return UICollectionViewCell()
        }
        cell.delegate = presenter
        cell.configure(with: presenter.menuItems[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CafeMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        calculateColectionViewCellSize(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        13
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        13
    }
}
