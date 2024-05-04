//
//  Advertisment.swift
//  MyApp
//
//  Created by Vlad on 4.05.24.
//

import Foundation

struct Advertisment: Codable {
    let id: String
    let imageURLStrings: [String]
    let description: String
    let price: Double
    let roomsCount: Double
    let location: String
    let ownerName: String
    let email: String
    let phoneNumber: String
}
