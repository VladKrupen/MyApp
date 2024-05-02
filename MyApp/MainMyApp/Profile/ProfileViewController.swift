//
//  SetupViewController.swift
//  MyApp
//
//  Created by Vlad on 23.04.24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profileView: ProfileView = {
        let profileView = ProfileView()
        profileView.translatesAutoresizingMaskIntoConstraints = false
        return profileView
    }()
    
    lazy var model = ProfileModel(profileViewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutProfileView()
        signOutButtonTapped()
    }
    
    private func layoutProfileView() {
        view.addSubview(profileView)
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func signOutButtonTapped() {
        profileView.closureSignOutButton = { [weak self] in
            self?.model.signOutProfile()
        }
    }
}
