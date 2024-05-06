//
//  SavedViewController.swift
//  MyApp
//
//  Created by Vlad on 24.04.24.
//

import UIKit

final class SavedViewController: UIViewController {
    
    let searchView = SearchView()
    lazy var model = SavedModel(savedController: self, firebaseAdvertismentManager: firebaseAdvertismentManager)
    
    private let firebaseAdvertismentManager = FirebaseAdvertismentManager()
    
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupDelegates()
        model.getFavouriteAdvertisment()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.getFavouriteAdvertisment()
    }
    
    private func setupDelegates() {
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Сохраненное"
    }
}

extension SavedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.displayedFavouritesAdvertisments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AdvertismentCollectionViewCell.self), for: indexPath)
        guard let advertismentCell = cell as? AdvertismentCollectionViewCell else { return cell }
        let advertisment = model.displayedFavouritesAdvertisments[indexPath.row]
        advertismentCell.setupCell(advertisment: advertisment)
        
        advertismentCell.likeButtonPressed = { [weak self] likedAdvertisment in
            
        }
        return advertismentCell
    }
}

extension SavedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAdvertisment = model.displayedFavouritesAdvertisments[indexPath.row]
        let adViewController = AdertismentViewController(advertisment: selectedAdvertisment)
        navigationController?.pushViewController(adViewController, animated: true)
    }
}
