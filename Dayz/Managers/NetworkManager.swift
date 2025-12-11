//
//  NetworkManager.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 11.12.2025.
//

import Foundation
import FirebaseFirestore

// Singleton Network Manager
class NetworkManager {
    static let shared = NetworkManager()
    private let db = Firestore.firestore()
    
    private init() {
        
    }
    
    // MARK: - Create Private User
    func createPrivateUser(_ user: User, completion: @escaping (Bool) -> Void) {
        let privateData = PrivateUser(id: user.id,
                                      email: user.email,
                                      createdAt: user.createdAt)
        
        do {
            try db.collection("privateUsers")
                .document(user.id)
                .setData(from: privateData) { error in
                    if let error = error {
                        print("Private user save error:", error)
                        completion(false)
                    } else {
                        completion(true)
                    }
                }
        } catch {
            print("Encoding error:", error)
            completion(false)
        }
    }
    
    // MARK: - Create Public User
    func createPublicUser(_ user: User, completion: @escaping (Bool) -> Void) {
        
        let publicData = PublicUser(id: user.id,
                                    username: user.username.lowercased(),
                                    name: user.name,
                                    bio: user.bio,
                                    avatarUrl: user.avatarUrl,
                                    followers: user.followers,
                                    following: user.following)
        
        do {
            try db.collection("publicUsers")
                .document(user.id)
                .setData(from: publicData) { error in
                    if let error = error {
                        print("Public user save error:", error)
                        completion(false)
                    } else {
                        completion(true)
                    }
                }
        } catch {
            print("Encoding error:", error)
            completion(false)
        }
    }
    
    // MARK: - Check Username Availability
    func checkUsernameExists(_ username: String, completion: @escaping (Bool) -> Void) {
        
        db.collection("publicUsers")
            .whereField("username", isEqualTo: username.lowercased())
            .getDocuments { snapshot, error in
                
                if let error = error {
                    print("Username check error:", error)
                    completion(true) // error -> return already exists
                    return
                }
                
                if let documents = snapshot?.documents, !documents.isEmpty {
                    completion(true)  // username already exists
                } else {
                    completion(false) // username is available
                }
            }
    }
}
