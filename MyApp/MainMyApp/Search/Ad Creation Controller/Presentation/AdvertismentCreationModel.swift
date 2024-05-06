//
//  AdCreationModel.swift
//  MyApp
//
//  Created by Vlad on 1.05.24.
//

import Foundation
import UIKit

final class AdvertismentCreationModel {
    
    var selectedImagesData: [Data?] = []
    
    weak private var adCreationViewController: AdvertismentCreationViewController?
    private let imagesUploader: ImagesUploader
    private let advertismentUploader: AdvertismentUploader
   
    init(adCreationViewController: AdvertismentCreationViewController?, imagesUploader: ImagesUploader, advertismentUploader: AdvertismentUploader) {
        self.adCreationViewController = adCreationViewController
        self.imagesUploader = imagesUploader
        self.advertismentUploader = advertismentUploader
    }
    
    func createAdvertisment(advertisment: Advertisment) {
        adCreationViewController?.showSpiner()
        let unwrappedImagesData = selectedImagesData.compactMap { $0 }
        imagesUploader.uploadImages(id: advertisment.id, imagesData: unwrappedImagesData) { [weak self] result in
            switch result {
            case .success(let imagesURLs):
                var newAdvertisment = advertisment
                newAdvertisment.appendImagesUrls(urls: imagesURLs)
                self?.checkingForEmptiness(for: newAdvertisment)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func checkingForEmptiness(for advertisment: Advertisment) {
        guard !advertisment.imageURLStrings.isEmpty,
              !advertisment.description.isEmpty,
              advertisment.price != 0.0,
              advertisment.roomsCount != 0.0,
              !advertisment.location.isEmpty,
              !advertisment.ownerName.isEmpty,
              !advertisment.email.isEmpty,
              !advertisment.phoneNumber.isEmpty else {
            self.adCreationViewController?.hideSpiner()
            self.adCreationViewController?.showAnnouncementAboutAddingData()
            return
        }
        self.uploadAdvertisment(advertisment: advertisment)
    }
    
    private func uploadAdvertisment(advertisment: Advertisment) {
        advertismentUploader.uploadAdvertisment(advertisment: advertisment) { [weak self] error in
            guard error == nil else {
                self?.adCreationViewController?.showFailedToLoadAdvertisment()
                return
            }
            self?.adCreationViewController?.hideSpiner()
            self?.adCreationViewController?.showSuccessedAdvertismentCreation()
        }
    }
}
