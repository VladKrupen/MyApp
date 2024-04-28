//
//  PhotoSelectionCell.swift
//  MyApp
//
//  Created by Vlad on 28.04.24.
//

import UIKit

class PhotoSelectionCell: UICollectionViewCell {
    
    private var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        layoutCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: getCompositionLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CellForPhotoSelectionCell.self, forCellWithReuseIdentifier: CellForPhotoSelectionCell.description())
    }
    
    private func getCompositionLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(1), heightDimension: .estimated(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(1), heightDimension: .estimated(1))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
            return section
        }
    }
    
    private func layoutCollectionView() {
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoSelectionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellForPhotoSelectionCell.description(), for: indexPath) as! CellForPhotoSelectionCell
        return cell
    }
}

extension PhotoSelectionCell: UICollectionViewDelegate{
    
}
