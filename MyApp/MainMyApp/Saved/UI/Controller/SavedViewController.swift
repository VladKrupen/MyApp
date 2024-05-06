//
//  SavedViewController.swift
//  MyApp
//
//  Created by Vlad on 24.04.24.
//

import UIKit

class SavedViewController: UIViewController {
    
    let searchView = SearchView()
    
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupDelegates()
        setupNavigationItem()
    }
    
//    private func setupDelegates() {
//        searchView.collectionView.dataSource = self
//        searchView.collectionView.delegate = self
//    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Сохраненное"
    }
}

//extension SavedViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//}

//extension SavedViewController: UICollectionViewDelegate {
//    
//}
