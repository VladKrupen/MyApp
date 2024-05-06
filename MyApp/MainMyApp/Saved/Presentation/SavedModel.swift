//
//  SavedModel.swift
//  MyApp
//
//  Created by Vlad on 5.05.24.
//

import Foundation

final class SavedModel {
    
    var displayedFavouritesAdvertisments = [Advertisment]()
    
    weak var savedController: SavedViewController?
    private let firebaseAdvertismentManager: FirebaseAdvertismentManager
    
    init(savedController: SavedViewController?, firebaseAdvertismentManager: FirebaseAdvertismentManager) {
        self.savedController = savedController
        self.firebaseAdvertismentManager = firebaseAdvertismentManager
    }
    
    func getFavouriteAdvertisment() {
        firebaseAdvertismentManager.getFavouriteAdvertismentsId { [weak self] result in
            switch result {
            case .success(let result):
                self?.firebaseAdvertismentManager.getFavouriteAdvertisments(favouritesAdventimentsId: result) { result in
                    switch result {
                    case .success(let advertisment):
                        self?.displayedFavouritesAdvertisments = advertisment
                        self?.savedController?.searchView.collectionView.reloadData()
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func changeAdvertismentFavouriteState(with id: String) {
        firebaseAdvertismentManager.changeAdvertismentFavouriteState(with: id)
        savedController?.showDeletedSuccessfully()
    }
}
