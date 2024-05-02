//
//  ProfileModel.swift
//  MyApp
//
//  Created by Vlad on 2.05.24.
//

import Foundation
import Firebase

class ProfileModel {
    
    weak var profileViewController: ProfileViewController?
    
    init(profileViewController: ProfileViewController? = nil) {
        self.profileViewController = profileViewController
    }
    
    func signOutProfile() {
        try? Auth.auth().signOut()
    }
}
