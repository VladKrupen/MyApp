//
//  CollectionViewCellForSearchView.swift
//  MyApp
//
//  Created by Vlad on 27.04.24.
//

import UIKit

class CollectionViewCellForSearchView: UICollectionViewCell {
    
    private var model: SearchModel = SearchModel()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        layoutElements()
    }
    
    private func setupCollectionViewImages() {
        collectionViewImages = UICollectionView(frame: .zero, collectionViewLayout: getCompositionLayout())
        collectionViewImages.translatesAutoresizingMaskIntoConstraints = false
        collectionViewImages.layer.cornerRadius = 20
        collectionViewImages.clipsToBounds = true
        collectionViewImages.isPagingEnabled = true
        collectionViewImages.dataSource = self
        collectionViewImages.delegate = self
        collectionViewImages.register(CellForCollectionImages.self, forCellWithReuseIdentifier: CellForCollectionImages.description())
    }
    
    private func setupElements() {
        setupCollectionViewImages()
        setupPageControl()
    }
    
    private func layoutElements() {
        layoutCollectionViewImages()
        layoutPageControl()
        layoutVerticalStack()
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
        pageControl.numberOfPages = model.getImages().count
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
        return model.getImages().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellForCollectionImages.description(), for: indexPath) as! CellForCollectionImages
        cell.imageView.image = model.getImages()[indexPath.item]
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
