//
//  PhotoSelectionCell.swift
//  MyApp
//
//  Created by Vlad on 28.04.24.
//

import UIKit

final class PhotoSelectionCell: UICollectionViewCell {
    
    var closureImageViewTapped: (() -> Void)?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        imageView.backgroundColor = CustomColor.customBlue
        imageView.layer.cornerRadius = 10
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutImageView()
        setupTapGestureForImageView()
    }
    
    private func layoutImageView() {
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    private func setupTapGestureForImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    func configureImageView(image: UIImage) {
        imageView.image = image
    }
    
    @objc private func imageViewTapped() {
        closureImageViewTapped?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
