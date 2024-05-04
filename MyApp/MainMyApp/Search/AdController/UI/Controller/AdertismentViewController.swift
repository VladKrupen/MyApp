//
//  AdViewController.swift
//  MyApp
//
//  Created by Vlad on 28.04.24.
//

import UIKit

final class AdertismentViewController: UIViewController {
    
    let contentView = AdvertismentView()
    
    private let advertisment: Advertisment
    
    init(advertisment: Advertisment) {
        self.advertisment = advertisment
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.setupView(advertisment: advertisment)
    }
}
