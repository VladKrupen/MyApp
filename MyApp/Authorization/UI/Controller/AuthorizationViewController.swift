//
//  AuthorizationViewController.swift
//  MyApp
//
//  Created by Vlad on 21.04.24.
//

import UIKit

final class AuthorizationViewController: UIViewController {
    
    private let authorizationView = AuthorizantionView()
    
    private let firebaseUserManager = FirebaseUserManager()
    
    lazy var model: AuthorizationModel = AuthorizationModel(authorizationController: self,
                                                            userAuthentication: firebaseUserManager,
                                                            userCreator: firebaseUserManager)
    
    override func loadView() {
        view = authorizationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonCustomViewTapped()
        textFieldCustomViewShouldReturn()
    }
    
    private func buttonCustomViewTapped() {
        authorizationView.closureButton = { [weak self] in
            self?.model.changeView()
        }
    }
    
    private func textFieldCustomViewShouldReturn() {
        authorizationView.closureTextFields = { [weak self] name, email, password in
            self?.model.userAuthorization(name: name, email: email, password: password)
        }
    }
    
    func isSignupFalse() {
        authorizationView.isSignupFalse()
    }
    
    func isSignupTrue() {
        authorizationView.isSignupTrue()
    }
    
    func showAlertAboutEmptyFields() {
        present(authorizationView.showAlertAboutEmptyFields(), animated: true)
    }
    
    func showAlertIncorrectData() {
        present(authorizationView.showAlertIncorrectData(), animated: true)
    }
    
    func showAlertIncorrectEmail() {
        present(authorizationView.showAlertIncorrectEmail(), animated: true)
    }
}
