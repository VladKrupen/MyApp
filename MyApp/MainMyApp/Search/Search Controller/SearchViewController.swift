//
//  SearchViewController.swift
//  MyApp
//
//  Created by Vlad on 24.04.24.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var searchView: SearchView = {
        let searchView = SearchView()
        searchView.translatesAutoresizingMaskIntoConstraints = false
        return searchView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        layoutSearchView()
        selectedItemFromCollectionView()
    }
    
    private func layoutSearchView() {
        view.addSubview(searchView)
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
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
    
    @objc private func createAdButtonTapped(_ sender: UIButton) {
        let adCreationViewController = AdCreationViewController()
        navigationController?.pushViewController(adCreationViewController, animated: false)
    }
}
