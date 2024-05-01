//
//  AdView.swift
//  MyApp
//
//  Created by Vlad on 1.05.24.
//

import UIKit

class AdView: UIView {
    
    private let model = SearchModel()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var collectionView: UICollectionView!
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "250$"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberOfRoomsLabel: UILabel = {
        let label = UILabel()
        label.text = "Количество комант 2"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let geolocationLabel: UILabel = {
        let label = UILabel()
        label.text = "Республика Беларусь, город Минск, Проспект независимости 58"
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = .gray
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        textView.text = """
In iOS 6 and later, assigning a new value to this property also replaces the value of the attributedText property with the same text, albeit without any inherent style attributes. Instead the text view styles the new string using the font, textColor, and other style-related properties of the class.
In iOS 6 and later, assigning a new value to this property also replaces the value of the attributedText property with the same text, albeit without any inherent style attributes. Instead the text view styles the new string using the font, textColor, and other style-related properties of the class.
"""
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.layer.cornerRadius = 15
        textView.layer.borderWidth = 1
        textView.layer.borderColor = CustomColor.customBlue.cgColor
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let stackDescription: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Арендодатель: Александр"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "Телефон для связи: +375297778899"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Почта для связи: test@test.ru"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackWithInformation: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        layoutElements()
    }
    
    private func setupElements() {
        setupCollectionView()
    }
    
    private func layoutElements() {
        layoutScrollView()
        layoutCollectionView()
        layoutVerticalStack()
        layoutStackDescription()
        layoutStackWithInformation()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: getCompositionLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CellForImages.self, forCellWithReuseIdentifier: CellForImages.description())
    }
    
    private func getCompositionLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            return section
        }
    }
    
    private func layoutScrollView() {
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func layoutCollectionView() {
        scrollView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }

    private func layoutVerticalStack() {
        verticalStack.addArrangedSubview(priceLabel)
        verticalStack.addArrangedSubview(numberOfRoomsLabel)
        verticalStack.addArrangedSubview(geolocationLabel)
        scrollView.addSubview(verticalStack)
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
        ])
    }
    
    private func layoutStackDescription() {
        stackDescription.addArrangedSubview(descriptionLabel)
        stackDescription.addArrangedSubview(textView)
        scrollView.addSubview(stackDescription)
        
        NSLayoutConstraint.activate([
            stackDescription.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 5),
            stackDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            stackDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
    }
    
    private func layoutStackWithInformation() {
        stackWithInformation.addArrangedSubview(nameLabel)
        stackWithInformation.addArrangedSubview(numberLabel)
        stackWithInformation.addArrangedSubview(emailLabel)
        scrollView.addSubview(stackWithInformation)
        
        NSLayoutConstraint.activate([
            stackWithInformation.topAnchor.constraint(equalTo: stackDescription.bottomAnchor, constant: 10),
            stackWithInformation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackWithInformation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: stackWithInformation.bottomAnchor, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AdView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.getImages().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellForImages.description(), for: indexPath) as! CellForImages
        cell.imageView.image = model.getImages()[indexPath.item]
        return cell
    }
}

extension AdView: UICollectionViewDelegate {
    
}
