//
//  FirebaseAdvertismentManager.swift
//  MyApp
//
//  Created by Vlad on 4.05.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class FirebaseAdvertismentManager: AdvertismentsGetter, AdvertismentLiker, AdvertismentFavouriteGetter, AdvertismentUploader {
  
    private let database = Firestore.firestore()
    private let auth = Auth.auth()
    
    func getAdvertisments(completion: @escaping (Result<[Advertisment], any Error>) -> Void) {
        database.collection(Constants.advertismentsDocName).getDocuments { snapshot, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let documents = snapshot?.documents else {
                let error = NSError(domain: "Can't get snapshot", code: 401)
                return
            }
            let documentsData = documents.map { $0.data() }
            let advertisments: [Advertisment?] = documentsData.map { documentJSON in
                let advertismentData = try? JSONSerialization.data(withJSONObject: documentJSON)
                guard let advertismentData else { return nil }
                let advertisment = try? JSONDecoder().decode(Advertisment.self, from: advertismentData)
                return advertisment
            }
            let unwrappedAdvertisments = advertisments.compactMap { $0 }
            completion(.success(unwrappedAdvertisments))
        }
    }
    
    func changeAdvertismentFavouriteState(with id: String) {
        getFavouriteAdvertismentsId { [weak self] result in
            switch result {
            case .success(let favouriteAdvertismentsIds):
                let isAdvertismentFavourite = favouriteAdvertismentsIds.contains(id)
                switch isAdvertismentFavourite {
                case true:
                    self?.removeAdvertismentFromFavourite(with: id)
                case false:
                    self?.addAdvertismentToFavourite(with: id)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getFavouriteAdvertismentsId(completion: @escaping (Result<[String], any Error>) -> Void) {
        guard let userId = auth.currentUser?.uid else {
            let error = NSError(domain: "Can't get user id", code: 401)
            completion(.failure(error))
            return }
        
        database.collection(Constants.userDocName).document(userId).getDocument { snapsot, error in
            guard error == nil else {
                completion(.failure(error!))
                return }
            
            guard let userJSON = snapsot?.data() else {
                let error = NSError(domain: "Can't get user JSON", code: 401)
                completion(.failure(error))
                return }
            
            guard let userData = try? JSONSerialization.data(withJSONObject: userJSON) else {
                let error = NSError(domain: "Can't get user data", code: 401)
                completion(.failure(error))
                return }
            
            guard let user = try? JSONDecoder().decode(User.self, from: userData) else {
                let error = NSError(domain: "Can't parse user", code: 401)
                completion(.failure(error))
                return }
            
            let favouriteAdvertisments = user.favouritesAdvertisments
            completion(.success(favouriteAdvertisments))
        }
    }
    
    func getFavouriteAdvertisments(favouritesAdventimentsId: [String], completion: @escaping (Result<[Advertisment], any Error>) -> Void) {
        database.collection(Constants.advertismentsDocName).getDocuments { snapshot, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let documents = snapshot?.documents else {
                let error = NSError(domain: "Can't get snapshot", code: 401)
                return
            }
            guard let documentsFilter = snapshot?.documents.filter({ favouritesAdventimentsId.contains($0.documentID) }) else {
                let error = NSError(domain: "Сan't filter", code: 401)
                completion(.failure(error))
                return
            }
            let documentsData = documentsFilter.map { $0.data() }
            let advertisments: [Advertisment?] = documentsData.map { documentJSON in
                let advertismentData = try? JSONSerialization.data(withJSONObject: documentJSON)
                guard let advertismentData else { return nil }
                let advertisment = try? JSONDecoder().decode(Advertisment.self, from: advertismentData)
                return advertisment
            }
            let unwrappedAdvertisments = advertisments.compactMap { $0 }
            completion(.success(unwrappedAdvertisments))
        }
    }
    
    
    func uploadAdvertisment(advertisment: Advertisment, completion: @escaping ((any Error)?) -> Void) {
        guard let userId = auth.currentUser?.uid else {
            let error = NSError(domain: "Can't get user id", code: 401)
            completion(error)
            return }
        
        let ref = database.collection(Constants.advertismentsDocName).document(advertisment.id)
        
        do {
            try ref.setData(from: advertisment)
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    private func addAdvertismentToFavourite(with id: String) {
        guard let userId = auth.currentUser?.uid else { return }
        let ref = database.collection(Constants.userDocName).document(userId)
        ref.updateData(["favouritesAdvertisments": FieldValue.arrayUnion([id])])
        
    }
    
    private func removeAdvertismentFromFavourite(with id: String) {
        guard let userId = auth.currentUser?.uid else { return }
        let ref = database.collection(Constants.userDocName).document(userId)
        ref.updateData(["favouritesAdvertisments": FieldValue.arrayRemove([id])])
    }
}
