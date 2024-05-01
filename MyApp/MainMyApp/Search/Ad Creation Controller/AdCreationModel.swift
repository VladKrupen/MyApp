//
//  AdCreationModel.swift
//  MyApp
//
//  Created by Vlad on 1.05.24.
//

import Foundation
import UIKit

class AdCreationModel {
    
    weak private var adCreationViewController: AdCreationViewController?
    
    init(adCreationViewController: AdCreationViewController? = nil) {
        self.adCreationViewController = adCreationViewController
    }
    
    var selectionImages: [UIImage] = []
    
}
