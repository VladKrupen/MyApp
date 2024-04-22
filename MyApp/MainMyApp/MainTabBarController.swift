//
//  MainTabBarController.swift
//  MyApp
//
//  Created by Vlad on 21.04.24.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            do {
                try Auth.auth().signOut()
            } catch {
                print(error)
            }
        }
    }
}
