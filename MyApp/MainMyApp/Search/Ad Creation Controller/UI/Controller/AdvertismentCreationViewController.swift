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
    
    private let firebaseImageUploader = FirebaseImageUploader()
    private let advertismentManager = FirebaseAdvertismentManager()
    
    private lazy var model = AdvertismentCreationModel(adCreationViewController: self, imagesUploader: firebaseImageUploader, advertismentUploader: advertismentManager)
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
    
    func showSpiner() {
        adCreationView.spinerView.startAnimating()
    }
    
    func hideSpiner() {
        adCreationView.spinerView.stopAnimating()
    }
    
    func showSuccessedAdvertismentCreation() {
        let alertController = UIAlertController(title: "Обявление добавлено", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .default) { [weak self ] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: false)
        }
    }
    
    func showAnnouncementAboutAddingData() {
        let alertController = UIAlertController(title: "Заполните все поля и добавьте фотографии", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .default) { [weak self ] _ in
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: false)
        }
    }
    
    func showFailedToLoadAdvertisment() {
        let alertController = UIAlertController(title: "Не удалось загрузить объявление, попробуйте позже", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .default) { [weak self ] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: false)
        }
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
            let emptyImageAdvertisment = Advertisment(id: UUID().uuidString,
                                                      imageURLStrings: [],
                                                      description: description,
                                                      price: price,
                                                      roomsCount: numberOfRooms,
                                                      location: geolocation,
                                                      ownerName: name,
                                                      email: email,
                                                      phoneNumber: number)
            self?.model.createAdvertisment(advertisment: emptyImageAdvertisment)
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
                        self.adCreationView.selectionImages.append(image)
                        self.model.selectedImagesData.append(image.jpegData(compressionQuality: 1))
                        self.adCreationView.collectionView.reloadData()
                    }
                }
            }
        }
        picker.dismiss(animated: true)
        if results.isEmpty {
            picker.dismiss(animated: true)
        }
    }
}

