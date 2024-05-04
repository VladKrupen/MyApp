//
//  User.swift
//  MyApp
//
//  Created by Vlad on 4.05.24.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let favouritesAdvertisments: [String]
}
