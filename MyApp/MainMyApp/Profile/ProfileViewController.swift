//
//  SetupViewController.swift
//  MyApp
//
//  Created by Vlad on 23.04.24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profileView = ProfileView()
    
    lazy var model = ProfileModel(profileViewController: self)
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        signOutButtonTapped()
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
