//
//  AdViewController.swift
//  MyApp
//
//  Created by Vlad on 28.04.24.
//

import UIKit

class AdViewController: UIViewController {
    
    private let adView: UIView = {
        let adView = AdView()
        adView.translatesAutoresizingMaskIntoConstraints = false
        return adView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutAdView()
    }
    
    private func layoutAdView() {
        view.addSubview(adView)
        
        NSLayoutConstraint.activate([
            adView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            adView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            adView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            adView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
