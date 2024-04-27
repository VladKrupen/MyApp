//
//  AuthorizationModel.swift
//  MyApp
//
//  Created by Vlad on 21.04.24.
//

import Foundation
import Firebase

class AuthorizationModel {
    
    weak private var authorizationController: AuthorizationViewController?
    
    init(authorizationController: AuthorizationViewController?) {
        self.authorizationController = authorizationController
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
        if !name.isEmpty && !email.isEmpty && !password.isEmpty {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error == nil {
                    if let result = result {
                        let reference = Database.database().reference().child("users")
                        reference.child(result.user.uid).updateChildValues(["name" : name, "email" : email])
                    }
                } else {
                    self.authorizationController?.showAlertIncorrectEmail()
                }
            }
        } else {
            authorizationController?.showAlertAboutEmptyFields()
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
