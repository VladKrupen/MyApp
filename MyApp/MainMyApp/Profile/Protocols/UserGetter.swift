//
//  UserGetter.swift
//  MyApp
//
//  Created by Vlad on 4.05.24.
//

import Foundation

protocol UserGetter {
    func getCurrentUser(completion: @escaping (Result<User, Error>) -> Void)
}
