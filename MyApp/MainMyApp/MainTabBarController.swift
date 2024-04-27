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
        view.backgroundColor = .white
        setupTabBar()
        setTabBarAppearance()
    }
    
    private func setupTabBar() {
        let savedViewController = createNavigationController(viewController:            SavedViewController(), itemName: "Сохраненное", itemImage: "heart", tag: 0)
        let searchViewController = createNavigationController(viewController: SearchViewController(), itemName: "Найти", itemImage: "magnifyingglass", tag: 1)
        let profileController = createNavigationController(viewController: ProfileViewController(), itemName: "Профиль", itemImage: "person.crop.circle", tag: 2)
        viewControllers = [savedViewController, searchViewController, profileController]
        selectedViewController = searchViewController
    }
    
    private func createNavigationController(viewController: UIViewController, itemName: String, itemImage: String, tag: Int) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage), tag: tag)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = item
        return navigationController
    }
    
    private func setTabBarAppearance() {
        tabBar.tintColor = CustomColor.customBlue
    }
}
