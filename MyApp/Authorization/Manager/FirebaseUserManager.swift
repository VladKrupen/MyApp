//
//  FirebaseUserManager.swift
//  MyApp
//
//  Created by Vlad on 4.05.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class FirebaseUserManager: UserAuthentication, UserCreator {
    
    private let auth = Auth.auth()
    private let database = Firestore.firestore()
    
    func authUser(email: String, password: String, completion: @escaping ((any Error)?) -> Void) {
        auth.createUser(withEmail: email, password: password) { _, error in
            completion(error)
        }
    }
    
    func createUser(name: String, email: String, completion: @escaping ((any Error)?) -> Void) {
        guard let userId = auth.currentUser?.uid else {
            let error = NSError(domain: "Can't create user id", code: 401)
            completion(error)
            return
        }
        
        let newUser = User(id: userId, name: name, email: email, favouritesAdvertisments: [])
        
        guard let newUserData = try? JSONEncoder().encode(newUser) else {
            let error = NSError(domain: "Can't create user data", code: 401)
            completion(error)
            return
        }
        
        guard let userJSON = try? JSONSerialization.jsonObject(with: newUserData) as? [String: Any] else {
            let error = NSError(domain: "Can't create user JSON", code: 401)
            completion(error)
            return
        }
        
        database.collection(Constants.userDocName).document(userId).setData(userJSON, completion: completion)
    }
}
