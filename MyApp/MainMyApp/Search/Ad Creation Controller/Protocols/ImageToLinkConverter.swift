//
//  ImageToLinkConverter.swift
//  MyApp
//
//  Created by Vlad on 5.05.24.
//

import Foundation
import UIKit

protocol ImageToStringConverter {
    func convertImagesToStrings(image: UIImage, completion: @escaping (Result<String, Error>) -> Void)
}
