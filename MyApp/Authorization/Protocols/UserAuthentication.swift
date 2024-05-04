//
//  UserAuthentication.swift
//  MyApp
//
//  Created by Vlad on 4.05.24.
//

import Foundation

protocol UserAuthentication {
    func authUser(email: String, password: String, completion: @escaping (Error?) -> Void) 
}
