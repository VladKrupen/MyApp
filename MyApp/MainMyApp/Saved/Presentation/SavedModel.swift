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
    private let advertismentFavouriteGetter: AdvertismentFavouriteGetter
    private let advertismentLiker: AdvertismentFavouriteGetter
    
    init(savedController: SavedViewController?, firebaseAdvertismentManager: FirebaseAdvertismentManager, advertismentFavouriteGetter: AdvertismentFavouriteGetter, advertismentLiker: AdvertismentFavouriteGetter) {
        self.savedController = savedController
        self.firebaseAdvertismentManager = firebaseAdvertismentManager
        self.advertismentFavouriteGetter = advertismentFavouriteGetter
        self.advertismentLiker = advertismentLiker
    }
    
    func getFavouriteAdvertisment() {
        firebaseAdvertismentManager.getFavouriteAdvertismentsId { [weak self] result in
            switch result {
            case .success(let favouritesId):
                self?.firebaseAdvertismentManager.getFavouriteAdvertisments(favouritesAdventimentsId: favouritesId) { result in
                    switch result {
                    case .success(let advertisments):
                        self?.updateFavouriteState(for: advertisments)
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateFavouriteState(for advertisments: [Advertisment]) {
        var favouriteAdvertisments: [Advertisment] = []
        
        for advertisment in advertisments {
            var favouriteAdvertisment = advertisment
            favouriteAdvertisment.isFavourite = true
            favouriteAdvertisments.append(favouriteAdvertisment)
        }
        
        displayedFavouritesAdvertisments = favouriteAdvertisments
        checkEmptyState()
        savedController?.savedView.collectionView.reloadData()
    }
    
    
    func changeAdvertismentFavouriteState(with id: String) {
        firebaseAdvertismentManager.changeAdvertismentFavouriteState(with: id) { [weak self] in
            self?.getFavouriteAdvertisment()
            self?.savedController?.showDeletedSuccessfully()
        }
    }
    
    private func checkEmptyState() {
        let needDisplayEmptyState = displayedFavouritesAdvertisments.isEmpty
        savedController?.savedView.emptyLabel.isHidden = !needDisplayEmptyState
    }
}
