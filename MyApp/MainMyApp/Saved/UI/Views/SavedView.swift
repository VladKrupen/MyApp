//
//  SavedView.swift
//  MyApp
//
//  Created by Vlad on 6.05.24.
//

import UIKit

final class SavedView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = getCompositionLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AdvertismentCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: AdvertismentCollectionViewCell.self))
        return collectionView
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Нет сохраненных объявлений"
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getCompositionLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
    
    private func layoutElements() {
        layoutCollectionView()
        layoutEmptyLabel()
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
    
    private func layoutEmptyLabel() {
        addSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            emptyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
        ])
    }
}
