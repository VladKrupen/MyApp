//
//  AuthorizationModel.swift
//  MyApp
//
//  Created by Vlad on 21.04.24.
//

import Foundation

class AuthorizationModel {
    
    private let view: AuthorizantionView
    
    init(view: AuthorizantionView) {
        self.view = view
    }
    
    private var signup: Bool = false {
        willSet {
            if !newValue {
                view.isSignupFalse()
            } else {
                view.isSignupTrue()
            }
        }
    }
    
    func changeView() {
        signup.toggle()
    }
    
}
