//
//  SearchModel.swift
//  MyApp
//
//  Created by Vlad on 27.04.24.
//

import Foundation

final class SearchModel {
    
    weak var searchViewController: SearchViewController?
    
    var displayedAdvertisments = [Advertisment]()
    
    private let advertismentGetter: AdvertismentsGetter
    private let advertismentFavouriteGetter: AdvertismentFavouriteGetter
    private let advertismentLiker: AdvertismentLiker
    
    init(searchViewController: SearchViewController?, advertismentGetter: AdvertismentsGetter, advertismentLiker: AdvertismentLiker, advertismentFavouriteGetter: AdvertismentFavouriteGetter) {
        self.searchViewController = searchViewController
        self.advertismentGetter = advertismentGetter
        self.advertismentLiker = advertismentLiker
        self.advertismentFavouriteGetter = advertismentFavouriteGetter
    }
    
    func changeLikeButtonState(for advertisment: Advertisment) {
        var newAdvertisment = advertisment
        newAdvertisment.isFavourite.toggle()
        
        let removedIndex = displayedAdvertisments.firstIndex { $0.id == advertisment.id }
        guard let removedIndex else { return }
        displayedAdvertisments.remove(at: removedIndex)
        displayedAdvertisments.insert(newAdvertisment, at: removedIndex)
        
        if newAdvertisment.isFavourite {
            searchViewController?.showAdvertismentSuccessfullyAddedToSaved()
        } else {
            searchViewController?.showAdSuccessfullyDeletedFromSaved()
        }
        
        searchViewController?.contentView.collectionView.reloadData()
    }
    
    func getAdvertisments() {
        advertismentGetter.getAdvertisments { [weak self] result in
            switch result {
            case .success(let advertisments):
                self?.detectedFavouriteAdvertisments(advertisments: advertisments)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func detectedFavouriteAdvertisments(advertisments: [Advertisment]) {
        advertismentFavouriteGetter.getFavouriteAdvertismentsId(completion: { [weak self] result in
            switch result {
            case .success(let favouriteIds):
                var updatedAdvertisments: [Advertisment] = []
                
                for advertisment in advertisments {
                    guard favouriteIds.contains(advertisment.id) else {
                        updatedAdvertisments.append(advertisment)
                        continue
                    }
                    var favouriteAdvertisment = advertisment
                    favouriteAdvertisment.isFavourite = true
                    updatedAdvertisments.append(favouriteAdvertisment)
                }
                
                self?.displayedAdvertisments = updatedAdvertisments
                self?.searchViewController?.contentView.collectionView.reloadData()
            case .failure(let error):
                print("Can't get favourite advertisemnt id's")
            }
        })
    }
    
    func changeAdvertismentFavouriteState(with advertisment: Advertisment) {
        advertismentLiker.changeAdvertismentFavouriteState(with: advertisment.id) { [weak self] in
            self?.changeLikeButtonState(for: advertisment)
        }
    }
}
