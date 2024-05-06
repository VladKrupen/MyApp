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
    private let advertismentLiker: AdvertismentLiker
    
    init(searchViewController: SearchViewController?, advertismentGetter: AdvertismentsGetter, advertismentLiker: AdvertismentLiker) {
        self.searchViewController = searchViewController
        self.advertismentGetter = advertismentGetter
        self.advertismentLiker = advertismentLiker
    }
    
    var like: Bool = false 
    
    func changeLikeButton() {
        like.toggle()
        if like {
            searchViewController?.showAdvertismentSuccessfullyAddedToSaved()
        } else {
            searchViewController?.showAdSuccessfullyDeletedFromSaved()
        }
    }
    
    func getAdvertisments() {
        advertismentGetter.getAdvertisments { [weak self] result in
            switch result {
            case .success(let advertisments):
                self?.displayedAdvertisments = advertisments
                self?.searchViewController?.contentView.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func changeAdvertismentFavouriteState(with id: String) {
        advertismentLiker.changeAdvertismentFavouriteState(with: id)
        changeLikeButton()
    }
}

