//
//  AdCreationModel.swift
//  MyApp
//
//  Created by Vlad on 1.05.24.
//

import Foundation
import UIKit

final class AdvertismentCreationModel {
    
    weak private var adCreationViewController: AdvertismentCreationViewController?
    
    let imageToStringConverter: ImageToStringConverter
   
    init(adCreationViewController: AdvertismentCreationViewController?, imageToStringConverter: ImageToStringConverter) {
        self.adCreationViewController = adCreationViewController
        self.imageToStringConverter = imageToStringConverter
    }
    
    
    func convertImagesToStrings(images: UIImage) -> String {
        var string: String = ""
        imageToStringConverter.convertImagesToStrings(image: images) { result in
            switch result {
            case .success(let strings):
                string = strings
            case .failure(let error):
                print(error)
            }
        }
        return string
    }
    
    var selectionImages: [UIImage] = []
    
}
