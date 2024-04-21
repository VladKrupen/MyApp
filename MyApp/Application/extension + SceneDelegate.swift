//
//  extension + SceneDelegate.swift
//  MyApp
//
//  Created by Vlad on 21.04.24.
//

import UIKit

extension SceneDelegate {
    static var shared: SceneDelegate = SceneDelegate()
    
    var rootViewController: RootViewController {
        var rootViewController: RootViewController!
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let rootController = windowScene.windows.first?.rootViewController {
            rootViewController = rootController as? RootViewController
        }
        return rootViewController
    }
}
