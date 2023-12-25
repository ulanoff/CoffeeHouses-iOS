// 
//  SignUpViewController.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 24.12.2023.
//

import UIKit

import UIKit
import SnapKit

protocol SignUpViewProtocol: AnyObject {
    func showError(error: SignUpError)
    func showSuccess()
    func showLoader()
    func hideLoader()
}

final class SignUpViewController: UIViewController {
    var presenter: SignUpPresenterProtocol?
    
    // MARK: - UI Elements
    
    private lazy var emailField: CHTextFieldWithLabel = {
        let field = CHTextFieldWithLabel(labelText: "signUp-emailField-label"~,
                                         placeholder: "example@example.com")
        field.textField.addTarget(self, action: #selector(emailFieldChanged), for: .editingChanged)
        field.textField.textContentType = .emailAddress
        field.textField.autocapitalizationType = .none
        return field
    }()
    
    private lazy var passwordField: CHTextFieldWithLabel = {
        let field = CHTextFieldWithLabel(labelText: "signUp-passwordField-label"~,
                                         placeholder: "")
        field.textField.addTarget(self, action: #selector(passwordFieldChanged), for: .editingChanged)
        field.textField.isSecureTextEntry = true
        field.textField.textContentType = .none
        field.textField.autocapitalizationType = .none
        return field
    }()
    
    private lazy var repeatPasswordField: CHTextFieldWithLabel = {
        let field = CHTextFieldWithLabel(labelText: "signUp-passwordRepeatField-label"~,
                                         placeholder: "")
        field.textField.addTarget(self, action: #selector(repeatPasswordFieldChanged), for: .editingChanged)
        field.textField.isSecureTextEntry = true
        field.textField.textContentType = .none
        field.textField.autocapitalizationType = .none
        return field
    }()
    
    private lazy var submitButton: CHButton = {
        let button = CHButton()
        button.setTitle("signUp-submitButton"~, for: .normal)
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
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
        stackView.addArrangedSubview(repeatPasswordField)
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
private extension SignUpViewController {
    func submitButtonTapped() {
        presenter?.signUpButtonTapped()
    }
    
    func emailFieldChanged() {
        guard let text = emailField.textField.text else { return }
        presenter?.loginChanged(login: text)
    }
    
    func passwordFieldChanged() {
        guard let text = passwordField.textField.text else { return }
        presenter?.passwordChanged(password: text)
    }
    
    func repeatPasswordFieldChanged() {
        guard let text = repeatPasswordField.textField.text else { return }
        presenter?.repeatedPasswordChanged(password: text)
    }
}

// MARK: - Private Methods

private extension SignUpViewController {
    
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
            make.bottom.equalToSuperview()
        }
        centerContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeArea)
            make.centerY.equalToSuperview()
        }
        
        // views configuring
        title = "signUp-title"~
        view.backgroundColor = .chWhite
    }
}

// MARK: - SignInViewProtocol

extension SignUpViewController: SignUpViewProtocol {
    func showLoader() {
        UIBlockingProgressHUD.show()
    }
    
    func hideLoader() {
        UIBlockingProgressHUD.dismiss()
    }
    
    func showError(error: SignUpError) {
        showAlert(title: nil, message: error.localizedDescription)
    }
    
    func showSuccess() {
        showAlert(title: nil, message: "signUp-successAlert-msg"~)
    }
}
