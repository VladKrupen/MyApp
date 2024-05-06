//
//  AdvertismentFavouriteGetter.swift
//  MyApp
//
//  Created by Vlad on 4.05.24.
//

import Foundation

protocol AdvertismentFavouriteGetter {
    func getFavouriteAdvertismentsId(completion: @escaping (Result<[String], Error>) -> Void)
    func getFavouriteAdvertisments(favouritesAdventimentsId: [String] ,completion: @escaping (Result<[Advertisment], Error>) -> Void)
}
