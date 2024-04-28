//
//  AdCreationViewController.swift
//  MyApp
//
//  Created by Vlad on 28.04.24.
//

import UIKit

class AdCreationViewController: UIViewController {
    
    private let adCreationView: AdCreationView = {
        let adCreationView = AdCreationView()
        adCreationView.translatesAutoresizingMaskIntoConstraints = false
        return adCreationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        layoutAdCreationView()
    }
    
    private func layoutAdCreationView() {
        view.addSubview(adCreationView)
        
        NSLayoutConstraint.activate([
            adCreationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            adCreationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            adCreationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            adCreationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Подача объявления"
    }
}
