//
//  SavedViewController.swift
//  MyApp
//
//  Created by Vlad on 24.04.24.
//

import UIKit

final class SavedViewController: UIViewController {
    
    let savedView = SavedView()

    lazy var model = SavedModel(savedController: self, firebaseAdvertismentManager: firebaseAdvertismentManager, advertismentFavouriteGetter: firebaseAdvertismentManager, advertismentLiker: firebaseAdvertismentManager)
    
    private let firebaseAdvertismentManager = FirebaseAdvertismentManager()
    
    override func loadView() {
        view = savedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.getFavouriteAdvertisment()
    }
    
    private func setupDelegates() {
        savedView.collectionView.dataSource = self
        savedView.collectionView.delegate = self
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Сохраненное"
    }
    
    func showDeletedSuccessfully() {
        let alertController = UIAlertController(title: "Удалено из сохраненного", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .default) { [weak self ] _ in
            self?.savedView.collectionView.reloadData()
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: false)
        }
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
            self?.model.changeAdvertismentFavouriteState(with: likedAdvertisment.id)
            self?.model.getFavouriteAdvertisment()
            self?.savedView.collectionView.reloadData()
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
