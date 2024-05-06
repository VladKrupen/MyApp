//
//  SearchViewController.swift
//  MyApp
//
//  Created by Vlad on 24.04.24.
//

import UIKit

final class SearchViewController: UIViewController {
    
    let contentView = SearchView()
    
    lazy var model = SearchModel(searchViewController: self,
                                 advertismentGetter: firebaseAdvertismentManager,
                                 advertismentLiker: firebaseAdvertismentManager)
    
    private let firebaseAdvertismentManager = FirebaseAdvertismentManager()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.getAdvertisments()
    }
    
    func showAdvertismentSuccessfullyAddedToSaved() {
        let alertController = UIAlertController(title: "Обявление добавлено в сохраненное", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .default) { [weak self ] _ in
            
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: false)
        }
    }
    
    func showAdSuccessfullyDeletedFromSaved() {
        let alertController = UIAlertController(title: "Обявление удаленно из сохраненного", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .default) { [weak self ] _ in
            
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: false)
        }
    }
    
    private func setupDelegates() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Объявления"
        let createAdButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(createAdButtonTapped))
        createAdButton.tintColor = CustomColor.customBlue
        navigationItem.rightBarButtonItem = createAdButton
    }
    
    @objc private func createAdButtonTapped(_ sender: UIButton) {
        let adCreationViewController = AdvertismentCreationViewController()
        navigationController?.pushViewController(adCreationViewController, animated: false)
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.displayedAdvertisments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AdvertismentCollectionViewCell.self), for: indexPath)
        guard let advertismentCell = cell as? AdvertismentCollectionViewCell else { return cell }
        let advertisment = model.displayedAdvertisments[indexPath.row]
        advertismentCell.setupCell(advertisment: advertisment)
        
        advertismentCell.likeButtonPressed = { [weak self] likedAdvertisment in
            self?.model.changeAdvertismentFavouriteState(with: likedAdvertisment.id)
        }
        return advertismentCell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAdvertisment = model.displayedAdvertisments[indexPath.row]
        let adViewController = AdertismentViewController(advertisment: selectedAdvertisment)
        navigationController?.pushViewController(adViewController, animated: true)
    }
}
