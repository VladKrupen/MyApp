//
//  FirebaseImageUploader.swift
//  MyApp
//
//  Created by Vlad on 6.05.24.
//

import Foundation
import FirebaseStorage

final class FirebaseImageUploader: ImagesUploader {
    
    private let storage = Storage.storage()
    
    func uploadImages(id: String, imagesData: [Data], completion: @escaping (Result<[String], any Error>) -> Void) {
        
        var imageReferences: [StorageReference] = []
        
        for _ in imagesData {
            let imageName: String = UUID().uuidString
            let ref = storage.reference().child(Constants.advertismentsDocName).child(id).child(imageName)
            imageReferences.append(ref)
        }
        uploadImagesData(references: imageReferences, imagesData: imagesData) { [weak self] error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            self?.getImagesURLsString(references: imageReferences, completion: completion)
        }
    }
    
    private func uploadImagesData(references: [StorageReference], imagesData: [Data], completion: @escaping (Error?) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        for (index, imageData) in imagesData.enumerated() {
            dispatchGroup.enter()
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            references[index].putData(imageData, metadata: metadata) { _, error in
                dispatchGroup.leave()
                guard error == nil else {
                    completion(error!)
                    return
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            completion(nil)
        }
    }
    
    private func getImagesURLsString(references: [StorageReference], completion: @escaping (Result<[String], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        let lock = NSLock()
        var imageURLsString: [String?] = []
        
        for reference in references {
            dispatchGroup.enter()
            reference.downloadURL { imageURL, error in
                guard error == nil else {
                    completion(.failure(error!))
                    dispatchGroup.leave()
                    return
                }
                lock.lock()
                imageURLsString.append(imageURL?.absoluteString)
                lock.unlock()
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            let unwrappedURLsString = imageURLsString.compactMap { $0 }
            completion(.success(unwrappedURLsString))
        }
    }
}
