//
//  SearchViewController.swift
//  MyApp
//
//  Created by Vlad on 24.04.24.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    
    lazy var model = SearchModel(searchViewController: self)
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        selectedItemFromCollectionView()
        likeButtonTapped()
    }
    
    
    private func setupNavigationItem() {
        navigationItem.title = "Объявления"
        let createAdButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(createAdButtonTapped))
        createAdButton.tintColor = CustomColor.customBlue
        navigationItem.rightBarButtonItem = createAdButton
    }
    
    private func selectedItemFromCollectionView() {
        searchView.closureSelectedItemFromCollectionView = { [weak self] collectionView, indexPath in
            guard self != nil else { return }
            let adViewController = AdViewController()
            self?.navigationController?.pushViewController(adViewController, animated: false)
        }
    }
    
    private func likeButtonTapped() {
        searchView.closureLikeButton = { [weak self] button, indexPath in
            if self!.model.like {
                button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                button.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            print(indexPath.row)
            self!.model.changeLikeButton()
        }
    }
    
    @objc private func createAdButtonTapped(_ sender: UIButton) {
        let adCreationViewController = AdCreationViewController()
        navigationController?.pushViewController(adCreationViewController, animated: false)
    }
}
