//
//  FirebaseAdvertismentCreationManager.swift
//  MyApp
//
//  Created by Vlad on 5.05.24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

final class FirebaseAdvertismentCreationManager: ImageToStringConverter {
    
    func uploadImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            let error = NSError(domain: "Can't convert image", code: 401)
            completion(.failure(error))
            return
        }
        let storageRef = Storage.storage().reference()
        let id = UUID().uuidString
        let imageName = UUID().uuidString
        let imageRef = storageRef.child(Constants.advertismentsDocName).child(id).child(imageName)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(imageData, metadata: metadata) { metadata, error in
            guard error == nil else {
                let error = NSError(domain: "Can't upload image", code: 401)
                completion(.failure(error))
                return
            }
            imageRef.downloadURL { url, error in
                guard error == nil else {
                    let error = NSError(domain: "Can't download url", code: 401)
                    completion(.failure(error))
                    return
                }
                guard let downloadUrl = url else { return }
                completion(.success(downloadUrl.absoluteString))
            }
        }
    }
    
    func convertImagesToStrings(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        var imagesStrings: String = ""
        let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            self.uploadImage(image: image) { result in
                switch result {
                case .success(let urlString):
                    imagesStrings = urlString
                case .failure(let error):
                    print(error)
                }
                dispatchGroup.leave()
            }
        dispatchGroup.notify(queue: .main) {
            completion(.success(imagesStrings))
        }
    }
}
