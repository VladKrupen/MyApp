//
//  AdCreationView.swift
//  MyApp
//
//  Created by Vlad on 28.04.24.
//

import UIKit

class AdCreationView: UIView {
    
    private var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        layoutElements()
    }
    
    private func setupElements() {
        setupCollectionView()
    }
    
    private func layoutElements() {
        layoutCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: getCompositionLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.register(PhotoSelectionCell.self, forCellWithReuseIdentifier: PhotoSelectionCell.description())
    }
    
    private func getCompositionLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
    
    private func layoutCollectionView() {
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AdCreationView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoSelectionCell.description(), for: indexPath) as! PhotoSelectionCell
            return cell
        default:
            fatalError("Ошибка создания ячеек")
        }
    }
}




