//
//  SignInViewController.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 23.12.2023.
//

import UIKit
import SnapKit

protocol SignInViewProtocol: AnyObject {
    func showError(error: SignInError)
    func showSuccess()
    func showLoader()
    func hideLoader()
}

final class SignInViewController: UIViewController {
    var presenter: SignInPresenterProtocol?
    
    // MARK: - UI Elements
    
    private lazy var emailField: CHTextFieldWithLabel = {
        let field = CHTextFieldWithLabel(labelText: "signIn-emailField-label"~,
                                         placeholder: "example@example.com")
        field.textField.addTarget(self, action: #selector(emailFieldChanged), for: .editingChanged)
        field.textField.textContentType = .emailAddress
        field.textField.autocapitalizationType = .none
        return field
    }()
    
    private lazy var passwordField: CHTextFieldWithLabel = {
        let field = CHTextFieldWithLabel(labelText: "signIn-passwordField-label"~,
                                         placeholder: "")
        field.textField.addTarget(self, action: #selector(passwordFieldChanged), for: .editingChanged)
        field.textField.textContentType = .password
        field.textField.isSecureTextEntry = true
        field.textField.autocapitalizationType = .none
        return field
    }()
    
    private lazy var submitButton: CHButton = {
        let button = CHButton()
        button.setTitle("signIn-submitButton"~, for: .normal)
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(
            string: "signIn-signUpButton"~,
            attributes: [
                .font: UIFont.systemFont(ofSize: 15),
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setTitleColor(.chBrown, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var fieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        return stackView
    }()
    
    private lazy var centerContainerView = UIView()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
    }
    
}

// MARK: - Event Handling

@objc
private extension SignInViewController {
    func submitButtonTapped() {
        presenter?.signInButtonTapped()
    }
    
    func signUpButtonTapped() {
    }
    
    func emailFieldChanged() {
        guard let text = emailField.textField.text else { return }
        presenter?.loginChanged(login: text)
    }
    
    func passwordFieldChanged() {
        guard let text = passwordField.textField.text else { return }
        presenter?.passwordChanged(password: text)
    }
}

// MARK: - Private Methods

private extension SignInViewController {
    
    func showAlert(title: String?, message: String?) {
        guard title != nil || message != nil else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "alert-ok"~, style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        // subviews
        view.addSubview(centerContainerView)
        centerContainerView.addSubview(fieldsStackView)
        centerContainerView.addSubview(submitButton)
        centerContainerView.addSubview(signUpButton)
        
        // constraints
        let safeArea = view.safeAreaLayoutGuide
        fieldsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
        }
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(fieldsStackView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
        }
        signUpButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(submitButton)
            make.top.equalTo(submitButton.snp.bottom)
            make.height.equalTo(44)
            make.bottom.equalToSuperview()
        }
        centerContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeArea)
            make.centerY.equalToSuperview()
        }
        
        // views configuring
        title = "signIn-title"~
        view.backgroundColor = .chWhite
    }
}

// MARK: - SignInViewProtocol

extension SignInViewController: SignInViewProtocol {
    func showLoader() {
        UIBlockingProgressHUD.show()
    }
    
    func hideLoader() {
        UIBlockingProgressHUD.dismiss()
    }
    
    func showError(error: SignInError) {
        showAlert(title: nil, message: error.localizedDescription)
    }
    
    func showSuccess() {
        showAlert(title: nil, message: "signIn-successAlert-msg"~)
    }
}
