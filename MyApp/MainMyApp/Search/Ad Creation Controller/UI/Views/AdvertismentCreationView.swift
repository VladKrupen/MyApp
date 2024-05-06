//
//  AdCreationView.swift
//  MyApp
//
//  Created by Vlad on 28.04.24.
//

import UIKit

final class AdvertismentCreationView: UIView {
    
    var closurePostAdButton: ((String, Double, Double, String, String, String, String) -> Void)?
    
    var closureImageViewTapped: (() -> Void)?
    
    var selectionImages: [UIImage] = []
    
    var collectionView: UICollectionView!
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
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
        textView.isScrollEnabled = false
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
        backgroundColor = .white
        setupElements()
        layoutElements()
        scrollingWhenOpeningKeyboard()
        postAdButton.addTarget(self, action: #selector(postAdButtonTapped), for: .touchUpInside)
    }
    
    private func setupElements() {
        setupCollectionView()
        priceField.delegate = self
        numberOfRoomsField.delegate = self
        geolocationField.delegate = self
        nameField.delegate = self
        emailField.delegate = self
        numberField.delegate = self
    }
    
    private func layoutElements() {
        layoutScrollView()
        layoutCollectionView()
        layoutStackDescriptionElements()
        layoutStackTextField()
        layoutPostAdButton()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: getCompositionLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.register(PhotoSelectionCell.self, forCellWithReuseIdentifier: String(describing: PhotoSelectionCell.self))
    }
    
    private func getCompositionLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(1), heightDimension: .estimated(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(1), heightDimension: .estimated(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
            return section
        }
    }
    
    private func layoutScrollView() {
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func layoutCollectionView() {
        scrollView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func layoutStackDescriptionElements() {
        stackDescriptionElements.addArrangedSubview(descriptionLabel)
        stackDescriptionElements.addArrangedSubview(textView)
        scrollView.addSubview(stackDescriptionElements)
        
        NSLayoutConstraint.activate([
            stackDescriptionElements.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            stackDescriptionElements.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackDescriptionElements.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            textView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func layoutStackTextField() {
        stackTextField.addArrangedSubview(priceField)
        stackTextField.addArrangedSubview(numberOfRoomsField)
        stackTextField.addArrangedSubview(geolocationField)
        stackTextField.addArrangedSubview(nameField)
        stackTextField.addArrangedSubview(emailField)
        stackTextField.addArrangedSubview(numberField)
        scrollView.addSubview(stackTextField)
        
        NSLayoutConstraint.activate([
            stackTextField.topAnchor.constraint(equalTo: stackDescriptionElements.bottomAnchor, constant: 10),
            stackTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
    
    private func layoutPostAdButton() {
        scrollView.addSubview(postAdButton)
        
        NSLayoutConstraint.activate([
            postAdButton.topAnchor.constraint(equalTo: stackTextField.bottomAnchor, constant: 20),
            postAdButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            postAdButton.widthAnchor.constraint(equalToConstant: 200),
            scrollView.bottomAnchor.constraint(equalTo: postAdButton.bottomAnchor, constant: 10)
        ])
    }
    
    @objc private func postAdButtonTapped(_ sender: UIButton) {
        if let description = textView.text,
           let price = priceField.text,
           let numberOfRooms = numberOfRoomsField.text,
           let geolocation = geolocationField.text,
           let name = nameField.text,
           let email = emailField.text,
           let number = numberField.text {
            closurePostAdButton?(description, Double(price) ?? 0.0, Double(numberOfRooms) ?? 0.0, geolocation, name, email, number)
        }
    }
    
    private func scrollingWhenOpeningKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            scrollView.contentInset = contentInset
            scrollView.scrollIndicatorInsets = contentInset
            
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AdvertismentCreationView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectionImages.isEmpty {
            return 1
        } else {
            return selectionImages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoSelectionCell.self), for: indexPath) as! PhotoSelectionCell
        cell.closureImageViewTapped = { [weak self] in
            guard self != nil else { return }
            self?.closureImageViewTapped?()
        }
        if !selectionImages.isEmpty {
            cell.configureImageView(image: selectionImages[indexPath.item])
        } else {
            cell.configureImageView(image: UIImage(systemName: "camera")!)
        }
        return cell
    }
}

extension AdvertismentCreationView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let contentOffset = CGPoint(x: 0, y: textField.frame.origin.y + 50 - scrollView.contentInset.top)
                scrollView.setContentOffset(contentOffset, animated: true)
    }
}
