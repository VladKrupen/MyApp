//
//  AdCreationViewController.swift
//  MyApp
//
//  Created by Vlad on 28.04.24.
//

import UIKit
import PhotosUI

class AdCreationViewController: UIViewController {
    
    lazy var model = AdCreationModel(adCreationViewController: self)
    
    private let adCreationView: AdCreationView = {
        let adCreationView = AdCreationView()
        adCreationView.translatesAutoresizingMaskIntoConstraints = false
        return adCreationView
    }()
    
    lazy var pickerViewController: PHPickerViewController = {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.selectionLimit = 7
        let pickerViewController = PHPickerViewController(configuration: configuration)
        pickerViewController.delegate = self
        return pickerViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        layoutAdCreationView()
        imageViewTapped()
    }
    
    private func layoutAdCreationView() {
        view.addSubview(adCreationView)
        
        NSLayoutConstraint.activate([
            adCreationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            adCreationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            adCreationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            adCreationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
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
}

extension AdCreationViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        let itemProviders = results.map { $0.itemProvider }
        for item in itemProviders {
            item.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self.model.selectionImages.append(image)
                        self.addImages(images: self.model.selectionImages)
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

