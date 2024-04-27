//
//  SearchViewController.swift
//  MyApp
//
//  Created by Vlad on 24.04.24.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var searchView: SearchView = {
        let searchView = SearchView()
        searchView.translatesAutoresizingMaskIntoConstraints = false
        return searchView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSearchView()
    }
    
    private func layoutSearchView() {
        view.addSubview(searchView)
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
