//
//  UserCreator.swift
//  MyApp
//
//  Created by Vlad on 4.05.24.
//

import Foundation

protocol UserCreator {
    func createUser(name: String, email: String, completion: @escaping (Error?) -> Void)
}
