//
//  CollectionViewCellForSearchView.swift
//  MyApp
//
//  Created by Vlad on 27.04.24.
//

import UIKit

class CollectionViewCellForSearchView: UICollectionViewCell {
    
    var model: SearchModel = SearchModel()
    
    private var collectionViewImages: UICollectionView!
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
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
    }
    
    private func layoutCollectionViewImages() {
        contentView.addSubview(collectionViewImages)
        
        NSLayoutConstraint.activate([
            collectionViewImages.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            collectionViewImages.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            collectionViewImages.widthAnchor.constraint(equalToConstant: 300),
            collectionViewImages.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func getCompositionLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
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
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
    }
    
    @objc private func pageControlValueChanged(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        collectionViewImages.scrollToItem(at: IndexPath(item: currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionViewCellForSearchView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellForCollectionImages.description(), for: indexPath) as! CellForCollectionImages
        cell.imageView.image = model.getImages()[indexPath.item]
        return cell
    }
}

extension CollectionViewCellForSearchView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
