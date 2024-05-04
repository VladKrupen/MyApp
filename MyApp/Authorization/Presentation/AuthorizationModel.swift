//
//  AuthorizationModel.swift
//  MyApp
//
//  Created by Vlad on 21.04.24.
//

import Foundation
import Firebase

final class AuthorizationModel {
    
    weak private var authorizationController: AuthorizationViewController?
    
    private let userAuthentication: UserAuthentication
    private let userCreator: UserCreator
    
    init(authorizationController: AuthorizationViewController?, userAuthentication: UserAuthentication, userCreator: UserCreator) {
        self.authorizationController = authorizationController
        self.userAuthentication = userAuthentication
        self.userCreator = userCreator
    }
    
    private var signup: Bool = false {
        willSet {
            if !newValue {
                authorizationController?.isSignupFalse()
            } else {
                authorizationController?.isSignupTrue()
            }
        }
    }
    
    func changeView() {
        signup.toggle()
    }
    
    func userAuthorization(name: String, email: String, password: String) {
        if signup {
            userRegistration(name: name, email: email, password: password)
        } else {
            userLogin(email: email, password: password)
        }
    }
    
    private func userRegistration(name: String, email: String, password: String) {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            authorizationController?.showAlertAboutEmptyFields()
            return
        }
        userAuthentication.authUser(email: email, password: password) { [weak self] error in
            guard error == nil else {
                self?.authorizationController?.showAlertIncorrectEmail()
                return
            }
            self?.userCreator.createUser(name: name, email: email, completion: { [weak self] _ in
                SceneDelegate.shared.rootViewController.switchToScreen(viewController: MainTabBarController())
            })
        }
    }
    
    private func userLogin(email: String, password: String) {
        if !email.isEmpty && !password.isEmpty {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error != nil {
                    print("Не верный пароль")
                    self.authorizationController?.showAlertIncorrectData()
                }
            }
        } else {
            authorizationController?.showAlertAboutEmptyFields()
        }
    }
}
