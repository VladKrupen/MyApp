//
//  AdViewController.swift
//  MyApp
//
//  Created by Vlad on 28.04.24.
//

import UIKit

class AdViewController: UIViewController {
    
    private let adView = AdView()
    
    override func loadView() {
        view = adView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
