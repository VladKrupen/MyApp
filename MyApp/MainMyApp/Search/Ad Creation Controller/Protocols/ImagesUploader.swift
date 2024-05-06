//
//  ImagesUploader.swift
//  MyApp
//
//  Created by Vlad on 6.05.24.
//

import Foundation

protocol ImagesUploader {
    func uploadImages(id: String, imagesData: [Data], completion: @escaping (Result<[String], Error>) -> Void )
}
