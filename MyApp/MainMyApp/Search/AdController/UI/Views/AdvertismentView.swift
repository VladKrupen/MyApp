//
//  AdView.swift
//  MyApp
//
//  Created by Vlad on 1.05.24.
//

import UIKit

final class AdvertismentView: UIView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var scrollImagesView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private let imagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.isEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberOfRoomsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let geolocationLabel: UILabel = {
        let label = UILabel()
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
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
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
        layoutElements()
    }
    
    func setupView(advertisment: Advertisment) {
        setupImages(advertisment: advertisment)
        setupPageControl(advertisment: advertisment)
        priceLabel.text = "\(advertisment.price)$"
        numberOfRoomsLabel.text = "Количество комнат: \(Int(advertisment.roomsCount))"
        geolocationLabel.text = advertisment.location
        textView.text = advertisment.description
        nameLabel.text = "Арендодатель: \(advertisment.ownerName)"
        numberLabel.text = "Телефон для связи: \(advertisment.phoneNumber)"
        emailLabel.text = "Почта: \(advertisment.email)"
    }
    
    private func setupImages(advertisment: Advertisment) {
        for imageURLString in advertisment.imageURLStrings {
            let imageURL = URL(string: imageURLString)
            let imageView = createImageView()
            
            let placeholderImage = UIImage(systemName: "photo.on.rectangle.angled")
            imageView.sd_setImage(with: imageURL, placeholderImage: placeholderImage)
            imagesStackView.addArrangedSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalTo: scrollImagesView.frameLayoutGuide.widthAnchor, multiplier: 1)
            ])
        }
    }
    
    private func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }
    
    private func setupPageControl(advertisment: Advertisment) {
        pageControl.numberOfPages = advertisment.imageURLStrings.count
    }
    
    private func layoutElements() {
        layoutScrollView()
        layoutScrollImagesView()
        layoutImagesStackView()
        layoutPageControl()
        layoutVerticalStack()
        layoutStackDescription()
        layoutStackWithInformation()
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
    
    private func layoutScrollImagesView() {
        scrollView.addSubview(scrollImagesView)
        NSLayoutConstraint.activate([
            scrollImagesView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollImagesView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollImagesView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollImagesView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.7)
        ])
    }
    
    private func layoutImagesStackView() {
        scrollImagesView.addSubview(imagesStackView)
        NSLayoutConstraint.activate([
            imagesStackView.topAnchor.constraint(equalTo: scrollImagesView.frameLayoutGuide.topAnchor),
            imagesStackView.leadingAnchor.constraint(equalTo: scrollImagesView.contentLayoutGuide.leadingAnchor),
            imagesStackView.trailingAnchor.constraint(equalTo: scrollImagesView.contentLayoutGuide.trailingAnchor),
            imagesStackView.bottomAnchor.constraint(equalTo: scrollImagesView.frameLayoutGuide.bottomAnchor)
        ])
    }
    
    private func layoutPageControl() {
        scrollView.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: scrollImagesView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: scrollImagesView.bottomAnchor, constant: -10)
        ])
    }
    
    private func layoutVerticalStack() {
        verticalStack.addArrangedSubview(priceLabel)
        verticalStack.addArrangedSubview(numberOfRoomsLabel)
        verticalStack.addArrangedSubview(geolocationLabel)
        scrollView.addSubview(verticalStack)
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: scrollImagesView.bottomAnchor, constant: 10),
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

extension AdvertismentView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let onePageSize = scrollView.frame.width
        let currentXOffset = scrollView.contentOffset.x
        let currentPageIndex = Int(currentXOffset / onePageSize)
        pageControl.currentPage = currentPageIndex
    }
}
