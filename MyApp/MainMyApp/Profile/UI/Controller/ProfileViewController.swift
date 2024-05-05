//
//  SetupViewController.swift
//  MyApp
//
//  Created by Vlad on 23.04.24.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    let profileView = ProfileView()
    
    private let firebaseUserManager = FirebaseUserManager()
    
    lazy var model = ProfileModel(profileViewController: self,
                                  userGetter: firebaseUserManager)
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        signOutButtonTapped()
        model.getCurrentUser()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Профиль"
    }
    
    private func signOutButtonTapped() {
        profileView.closureSignOutButton = { [weak self] in
            self?.model.signOutProfile()
        }
    }
}
