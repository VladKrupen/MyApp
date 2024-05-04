//
//  AuthorizantionView.swift
//  MyApp
//
//  Created by Vlad on 21.04.24.
//

import UIKit

final class AuthorizantionView: UIView {
    
    var closureButton: (() -> Void)?
    var closureTextFields: ((String, String, String) -> Void)?
    
    private let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Вход"
        textLabel.font = UIFont.systemFont(ofSize: 34)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    private let nameField: UITextField = {
        let nameField = UITextField()
        nameField.placeholder = "Имя"
        nameField.borderStyle = .roundedRect
        nameField.isHidden = true
        nameField.translatesAutoresizingMaskIntoConstraints = false
        return nameField
    }()
    
    private let emailField: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = "Email"
        emailField.borderStyle = .roundedRect
        emailField.translatesAutoresizingMaskIntoConstraints = false
        return emailField
    }()
    
    private let passwordField: UITextField = {
        let passwordField = UITextField()
        passwordField.placeholder = "Пароль"
        passwordField.borderStyle = .roundedRect
        passwordField.textContentType = .oneTimeCode
        passwordField.isSecureTextEntry = true
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        return passwordField
    }()
    
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Регистрация", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutElements()
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        setupTextFields()
    }
    
    private func layoutElements() {
        layoutTextLabel()
        layoutVerticalStackView()
        layoutRegistrationButton()
    }
    
    private func layoutTextLabel() {
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func layoutVerticalStackView() {
        verticalStack.addArrangedSubview(nameField)
        verticalStack.addArrangedSubview(emailField)
        verticalStack.addArrangedSubview(passwordField)
        
        addSubview(verticalStack)
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 40),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
    }
    
    private func layoutRegistrationButton() {
        addSubview(registrationButton)
        
        NSLayoutConstraint.activate([
            registrationButton.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 20),
            registrationButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    @objc private func registrationButtonTapped(_ sender: UIButton) {
        closureButton?()
    }
    
    func isSignupFalse() {
        textLabel.text = "Вход"
        nameField.isHidden = true
        registrationButton.setTitle("Регистрация", for: .normal)
    }
    
    func isSignupTrue() {
        textLabel.text = "Регистрация"
        nameField.isHidden = false
        registrationButton.setTitle("Вход", for: .normal)
    }
    
    private func setupTextFields() {
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    func showAlertAboutEmptyFields() -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Хорошо", style: .default)
        alert.addAction(alertAction)
        return alert
    }
    
    func showAlertIncorrectData () -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка", message: "Неправильный логин или пароль.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Хорошо", style: .default)
        alert.addAction(alertAction)
        emailField.text = ""
        passwordField.text = ""
        return alert
    }
    
    func showAlertIncorrectEmail () -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка", message: "Некорректный адрес электронный почты.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Хорошо", style: .default)
        alert.addAction(alertAction)
        emailField.text = ""
        return alert
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuthorizantionView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            emailField.becomeFirstResponder()
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            textField.resignFirstResponder()
        default:
            break
        }
        if let name = nameField.text,
           let email = emailField.text,
           let password = passwordField.text {
            closureTextFields?(name, email, password)
        }
        return true
    }
}

