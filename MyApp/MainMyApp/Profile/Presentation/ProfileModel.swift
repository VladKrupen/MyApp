//
//  ProfileModel.swift
//  MyApp
//
//  Created by Vlad on 2.05.24.
//

import Foundation
import Firebase

final class ProfileModel {
    
    weak var profileViewController: ProfileViewController?
    
    private let userGetter: UserGetter
    
    init(profileViewController: ProfileViewController?, userGetter: UserGetter) {
        self.profileViewController = profileViewController
        self.userGetter = userGetter
    }
    
    func getCurrentUser() {
        userGetter.getCurrentUser { [weak self] result in
            switch result {
            case .success(let user):
                let currentUser = user
                self?.profileViewController?.profileView.setupProfileView(user: currentUser)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func signOutProfile() {
        try? Auth.auth().signOut()
    }
}
