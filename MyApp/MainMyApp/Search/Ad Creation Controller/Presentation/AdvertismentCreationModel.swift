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
    
    init(adCreationViewController: AdvertismentCreationViewController? = nil) {
        self.adCreationViewController = adCreationViewController
    }
    
    var selectionImages: [UIImage] = []
    
}
