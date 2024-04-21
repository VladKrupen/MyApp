//
//  AuthorizationViewController.swift
//  MyApp
//
//  Created by Vlad on 21.04.24.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    private let customView: AuthorizantionView = {
        let customView = AuthorizantionView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    
    lazy var model: AuthorizationModel = AuthorizationModel(view: customView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCustomView()
        buttonCustomViewTapped()
    }
    
    private func layoutCustomView() {
        view.addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func buttonCustomViewTapped() {
        customView.closureButton = { [weak self] in
            self?.model.changeView()
        }
    }
}
