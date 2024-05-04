//
//  CollectionViewCellForSearchView.swift
//  MyApp
//
//  Created by Vlad on 27.04.24.
//

import UIKit

class CollectionViewCellForSearchView: UICollectionViewCell {
    
    var closureLikeButton: ((UIButton) -> Void)?
    
    var images: [UIImage] = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!]
    
    private var collectionViewImages: UICollectionView!
    
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
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = CustomColor.customBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        layoutElements()
    }
    
    private func setupElements() {
        setupCollectionViewImages()
        setupPageControl()
        setupLikeButton()
    }
    
    private func layoutElements() {
        layoutCollectionViewImages()
        layoutPageControl()
        layoutVerticalStack()
        layoutLikeButton()
    }
    
    private func setupCollectionViewImages() {
        collectionViewImages = UICollectionView(frame: .zero, collectionViewLayout: getCompositionLayout())
        collectionViewImages.translatesAutoresizingMaskIntoConstraints = false
        collectionViewImages.layer.cornerRadius = 20
        collectionViewImages.clipsToBounds = true
        collectionViewImages.isPagingEnabled = true
        collectionViewImages.dataSource = self
        collectionViewImages.delegate = self
        collectionViewImages.register(CellForCollectionImages.self, forCellWithReuseIdentifier: String(describing: CellForCollectionImages.self))
    }
    
    private func layoutCollectionViewImages() {
        contentView.addSubview(collectionViewImages)
        
        NSLayoutConstraint.activate([
            collectionViewImages.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            collectionViewImages.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            collectionViewImages.widthAnchor.constraint(equalToConstant: 330),
            collectionViewImages.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func getCompositionLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        }
    }
    
    private func layoutPageControl() {
        contentView.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: collectionViewImages.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: collectionViewImages.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = images.count
    }
    
    private func layoutVerticalStack() {
        verticalStack.addArrangedSubview(numberOfRoomsLabel)
        verticalStack.addArrangedSubview(priceLabel)
        verticalStack.addArrangedSubview(geolocationLabel)
        
        contentView.addSubview(verticalStack)
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: collectionViewImages.bottomAnchor, constant: 10),
            verticalStack.leadingAnchor.constraint(equalTo: collectionViewImages.leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: collectionViewImages.trailingAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupLikeButton() {
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    private func layoutLikeButton() {
        contentView.addSubview(likeButton)
        
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: collectionViewImages.topAnchor, constant: 15),
            likeButton.trailingAnchor.constraint(equalTo: collectionViewImages.trailingAnchor, constant: -15)
        ])
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        closureLikeButton?(sender)
    }
    
    func configureCollectionViewCellForSearchView(numberOfRooms: String, price: String, geolocation: String) {
        numberOfRoomsLabel.text = "Комнат: " + numberOfRooms
        priceLabel.text = price + "$"
        geolocationLabel.text = "Адрес: " + geolocation
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionViewCellForSearchView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CellForCollectionImages.self), for: indexPath) as! CellForCollectionImages
        cell.imageView.image = images[indexPath.item]
        return cell
    }
}

extension CollectionViewCellForSearchView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let visibleIndexPath = collectionView.indexPathsForVisibleItems.first {
            pageControl.currentPage = visibleIndexPath.item
        }
    }
}
