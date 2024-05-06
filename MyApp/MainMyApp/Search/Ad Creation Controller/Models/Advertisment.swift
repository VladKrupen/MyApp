//
//  Advertisment.swift
//  MyApp
//
//  Created by Vlad on 4.05.24.
//

import Foundation

struct Advertisment: Codable {
    let id: String
    var imageURLStrings: [String]
    let description: String
    let price: Double
    let roomsCount: Double
    let location: String
    let ownerName: String
    let email: String
    let phoneNumber: String
    var isFavourite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageURLStrings
        case description
        case price
        case roomsCount
        case location
        case ownerName
        case email
        case phoneNumber
    }
    
    mutating func appendImagesUrls(urls: [String]) {
        imageURLStrings += urls
    }
}
