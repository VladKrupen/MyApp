//
//  CollectionViewCellForSearchView.swift
//  MyApp
//
//  Created by Vlad on 27.04.24.
//

import UIKit
import SDWebImage

final class AdvertismentCollectionViewCell: UICollectionViewCell {
    
    var likeButtonPressed: ((Advertisment) -> Void)?
    
    private var currentAdvertisment: Advertisment?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.layer.cornerRadius = 14
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
    
    private let numberOfRoomsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
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
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 5
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        return verticalStack
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = CustomColor.customBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(advertisment: Advertisment) {
        
        currentAdvertisment = advertisment
        
        numberOfRoomsLabel.text = "Комнат: " + "\(advertisment.roomsCount)"
        priceLabel.text = "\(advertisment.price)" + "$"
        geolocationLabel.text = "Адрес: " + advertisment.location
        
        setupImages(advertisment: advertisment)
        setupPageControl(advertisment: advertisment)
    }
    
    private func setupImages(advertisment: Advertisment) {
        for imageURLString in advertisment.imageURLStrings {
            let imageURL = URL(string: imageURLString)
            let imageView = createImageView()
            
            let placeholderImage = UIImage(systemName: "photo.on.rectangle.angled")
            imageView.sd_setImage(with: imageURL, placeholderImage: placeholderImage)
            imagesStackView.addArrangedSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 1)
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
        layoutImagesStackView()
        layoutPageControl()
        layoutVerticalStack()
        layoutLikeButton()
    }
    
    private func layoutScrollView() {
        contentView.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            scrollView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func layoutImagesStackView() {
        scrollView.addSubview(imagesStackView)
        NSLayoutConstraint.activate([
            imagesStackView.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            imagesStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            imagesStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            imagesStackView.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor)
        ])
    }
    
    private func layoutPageControl() {
        contentView.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
        ])
    }
    
    private func layoutVerticalStack() {
        verticalStack.addArrangedSubview(numberOfRoomsLabel)
        verticalStack.addArrangedSubview(priceLabel)
        verticalStack.addArrangedSubview(geolocationLabel)
        
        contentView.addSubview(verticalStack)
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
            verticalStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func layoutLikeButton() {
        contentView.addSubview(likeButton)
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            likeButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15)
        ])
    }
    
    @objc private func likeButtonTapped() {
        guard let currentAdvertisment else { return }
        self.likeButtonPressed?(currentAdvertisment)
    }
}

extension AdvertismentCollectionViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let onePageSize = scrollView.frame.width
        let currentXOffset = scrollView.contentOffset.x
        let currentPageIndex = Int(currentXOffset / onePageSize)
        
        pageControl.currentPage = currentPageIndex
    }
}
