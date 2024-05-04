//
//  ProfileView.swift
//  MyApp
//
//  Created by Vlad on 2.05.24.
//

import UIKit

class ProfileView: UIView {
    
    var closureSignOutButton: (() -> Void)?

    private let avatarImage: UIImageView = {
        let avatarImage = UIImageView()
        avatarImage.image = UIImage(systemName: "person")
        avatarImage.backgroundColor = CustomColor.customBlue
        avatarImage.tintColor = .white
        avatarImage.layer.cornerRadius = 50
        avatarImage.contentMode = .scaleToFill
        avatarImage.clipsToBounds = true
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        return avatarImage
    }()
    
    private let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Александр"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackNameLabels: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.layer.borderWidth = 1
        stack.layer.cornerRadius = 15
        stack.layer.borderColor = CustomColor.customBlue.cgColor
        stack.spacing = 5
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let emailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "test@test.ru"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackEmailLabels: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.layer.borderWidth = 1
        stack.layer.cornerRadius = 15
        stack.layer.borderColor = CustomColor.customBlue.cgColor
        stack.spacing = 5
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.layer.borderColor = CustomColor.customBlue.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutElemnts()
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
    }
    
    private func layoutElemnts() {
        layoutAvatarImage()
        layoutStackNameLabels()
        layoutStackEmailLabels()
        layoutSignOutButton()
    }

    private func layoutAvatarImage() {
        addSubview(avatarImage)
        
        NSLayoutConstraint.activate([
            avatarImage.widthAnchor.constraint(equalToConstant: 100),
            avatarImage.heightAnchor.constraint(equalToConstant: 100),
            avatarImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    private func layoutStackNameLabels() {
        stackNameLabels.addArrangedSubview(nameTitleLabel)
        stackNameLabels.addArrangedSubview(nameLabel)
        addSubview(stackNameLabels)
        
        NSLayoutConstraint.activate([
            stackNameLabels.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 20),
            stackNameLabels.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackNameLabels.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func layoutStackEmailLabels() {
        stackEmailLabels.addArrangedSubview(emailTitleLabel)
        stackEmailLabels.addArrangedSubview(emailLabel)
        addSubview(stackEmailLabels)
        
        NSLayoutConstraint.activate([
            stackEmailLabels.topAnchor.constraint(equalTo: stackNameLabels.bottomAnchor, constant: 10),
            stackEmailLabels.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackEmailLabels.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    private func layoutSignOutButton() {
        addSubview(signOutButton)
        
        NSLayoutConstraint.activate([
            signOutButton.topAnchor.constraint(equalTo: stackEmailLabels.bottomAnchor, constant: 10),
            signOutButton.leadingAnchor.constraint(equalTo: stackEmailLabels.leadingAnchor),
            signOutButton.trailingAnchor.constraint(equalTo: stackEmailLabels.trailingAnchor)
        ])
    }
    
    @objc private func signOutButtonTapped(_ sender: UIButton) {
        closureSignOutButton?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

