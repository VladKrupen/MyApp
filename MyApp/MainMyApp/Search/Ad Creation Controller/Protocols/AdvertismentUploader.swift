//
//  AdvertismentUploader.swift
//  MyApp
//
//  Created by Vlad on 6.05.24.
//

import Foundation

protocol AdvertismentUploader {
    func uploadAdvertisment(advertisment: Advertisment, completion: @escaping (Error?) -> Void)
}
