//
//  AdCreationViewController.swift
//  MyApp
//
//  Created by Vlad on 28.04.24.
//

import UIKit
import PhotosUI

final class AdvertismentCreationViewController: UIViewController {
    
    var imageStrings: [String] = []
    
    let firebaseAdvertismentCreationManager = FirebaseAdvertismentCreationManager()
    
//    lazy var model = AdvertismentCreationModel(adCreationViewController: self, imageToLinkConverter: firebaseAdvertismentCreationManager)
    lazy var model = AdvertismentCreationModel(adCreationViewController: self, firebaseManager: firebaseAdvertismentCreationManager)
    
    private let adCreationView = AdvertismentCreationView()
    
    lazy var pickerViewController: PHPickerViewController = {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.selectionLimit = 7
        let pickerViewController = PHPickerViewController(configuration: configuration)
        pickerViewController.delegate = self
        return pickerViewController
    }()
    
    override func loadView() {
        view = adCreationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        imageViewTapped()
        postAdButtonTapped()
    }
    
    func addImages(images: [UIImage]) {
        adCreationView.selectionImages = images
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Подача объявления"
    }
    
    private func imageViewTapped() {
        adCreationView.closureImageViewTapped = { [weak self] in
            guard self != nil else { return }
            self?.pickerViewController.modalPresentationStyle = .fullScreen
            self?.present(self!.pickerViewController, animated: true)
        }
    }
    
    private func postAdButtonTapped() {
        adCreationView.closurePostAdButton = { [weak self] description, price, numberOfRooms, geolocation, name, email, number in
        }
    }
}

extension AdvertismentCreationViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        let itemProviders = results.map { $0.itemProvider }
        for item in itemProviders {
            item.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self.imageStrings.append(self.model.convertImagesToStrings(images: image))
                        self.model.selectionImages.append(image)
                        self.addImages(images: self.model.selectionImages)
                        self.adCreationView.collectionView.reloadData()
                    }
                }
            }
        }
        print(imageStrings)
        picker.dismiss(animated: true)
        if results.isEmpty {
            picker.dismiss(animated: true)
        }
    }
}

