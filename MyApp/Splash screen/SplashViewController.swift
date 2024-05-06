//
//  SplashViewController.swift
//  MyApp
//
//  Created by Vlad on 21.04.24.
//

import UIKit
import FirebaseAuth
import Lottie

final class SplashViewController: UIViewController {
    
    let lottieAnimation = LottieAnimationView(name: "Splash")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        makeInquiries()
    }
    
    private func setupAnimation() {
        view.addSubview(lottieAnimation)
        lottieAnimation.frame = view.frame
        lottieAnimation.contentMode = .scaleAspectFit
        lottieAnimation.animationSpeed = 1
        lottieAnimation.loopMode = .loop
    }
    
    private func makeInquiries() {
        lottieAnimation.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            Auth.auth().addStateDidChangeListener { [weak self] auth, user in
                if user == nil {
                    SceneDelegate.shared.rootViewController.switchToScreen(viewController: AuthorizationViewController())
                } else {
                    SceneDelegate.shared.rootViewController.switchToScreen(viewController: MainTabBarController())
                }
            }
            self.lottieAnimation.stop()
        }
    }
}
