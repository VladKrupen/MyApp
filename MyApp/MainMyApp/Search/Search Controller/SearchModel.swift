//
//  SearchModel.swift
//  MyApp
//
//  Created by Vlad on 27.04.24.
//

import UIKit

class SearchModel {
    
    weak var searchViewController: SearchViewController?
    
    init(searchViewController: SearchViewController?) {
        self.searchViewController = searchViewController
    }
    
    var images: [UIImage] = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!]
    
    var like: Bool = true
    
    func changeLikeButton() {
        like.toggle()
    }
    
    func getImages() -> [UIImage] {
        let images = images
        return images
    }
}
