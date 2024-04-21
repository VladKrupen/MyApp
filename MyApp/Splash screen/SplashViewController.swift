//
//  SplashViewController.swift
//  MyApp
//
//  Created by Vlad on 21.04.24.
//

import UIKit

class SplashViewController: UIViewController {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        
        layoutElements()
        makeInquiries()
    }
    
    private func layoutElements() {
        layoutActivityIndicator()
    }
    
    private func layoutActivityIndicator() {
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func makeInquiries() {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.activityIndicator.stopAnimating()
            SceneDelegate.shared.rootViewController.switchToScreen(viewController: AuthorizationViewController())
        }
    }
    
}
