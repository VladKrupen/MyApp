//
//  AdvertismentsGetter.swift
//  MyApp
//
//  Created by Vlad on 4.05.24.
//

import Foundation

protocol AdvertismentsGetter {
    func getAdvertisments(completion: @escaping (Result<[Advertisment], Error>) -> Void)
}
