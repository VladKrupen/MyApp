//
//  AdvertismentFavouriteGetter.swift
//  MyApp
//
//  Created by Vlad on 4.05.24.
//

import Foundation

protocol AdvertismentFavouriteGetter {
    func getFavouriteAdvertisments(completion: @escaping (Result<[String], Error>) -> Void)
}
