//
//  DescriptionCell.swift
//  MyApp
//
//  Created by Vlad on 29.04.24.
//

import UIKit

class DescriptionCell: UICollectionViewCell {
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.layer.cornerRadius = 15
        textView.layer.borderWidth = 1
        textView.layer.borderColor = CustomColor.customBlue.cgColor
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let stackDescriptionElements: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let priceField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Цена в $"
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CustomColor.customBlue.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let numberOfRoomsField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Количество комант"
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CustomColor.customBlue.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let geolocationField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Местоположение"
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CustomColor.customBlue.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let nameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя"
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CustomColor.customBlue.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CustomColor.customBlue.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let numberField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "+375"
        textField.keyboardType = .phonePad
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = CustomColor.customBlue.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let stackTextField: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let postAdButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Подать объявление", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.backgroundColor = CustomColor.customBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutElements()
        postAdButton.addTarget(self, action: #selector(postAdButtonTapped), for: .touchUpInside)
    }
    
    private func layoutElements() {
        layoutStackDescriptionElements()
        layoutStackTextField()
        layoutPostAdButton()
    }

    private func layoutStackDescriptionElements() {
        stackDescriptionElements.addArrangedSubview(descriptionLabel)
        stackDescriptionElements.addArrangedSubview(textView)
        contentView.addSubview(stackDescriptionElements)
        
        NSLayoutConstraint.activate([
            stackDescriptionElements.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackDescriptionElements.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackDescriptionElements.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            textView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func layoutStackTextField() {
        stackTextField.addArrangedSubview(priceField)
        stackTextField.addArrangedSubview(numberOfRoomsField)
        stackTextField.addArrangedSubview(geolocationField)
        stackTextField.addArrangedSubview(nameField)
        stackTextField.addArrangedSubview(emailField)
        stackTextField.addArrangedSubview(numberField)
        contentView.addSubview(stackTextField)
        
        NSLayoutConstraint.activate([
            stackTextField.topAnchor.constraint(equalTo: stackDescriptionElements.bottomAnchor, constant: 10),
            stackTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    private func layoutPostAdButton() {
        contentView.addSubview(postAdButton)
        
        NSLayoutConstraint.activate([
            postAdButton.topAnchor.constraint(equalTo: stackTextField.bottomAnchor, constant: 20),
            postAdButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            postAdButton.widthAnchor.constraint(equalToConstant: 200),
            contentView.bottomAnchor.constraint(equalTo: postAdButton.bottomAnchor, constant: 10)
        ])
    }
    
    @objc private func postAdButtonTapped(_ sender: UIButton) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
