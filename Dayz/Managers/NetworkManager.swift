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
    let imageCache = NSCache<NSString, UIImage>()
    
    private init() {
        
    }
    
    // MARK: - Create Private User
    func createPrivateUser(_ user: User, completion: @escaping (Result<Void, DZError>) -> Void) {
        let privateData = PrivateUser(id: user.id,
                                      email: user.email,
                                      createdAt: user.createdAt)
        
        do {
            try db.collection("privateUsers")
                .document(user.id)
                .setData(from: privateData) { error in
                    if let error = error {
                        print("Private user save error:", error)
                        completion(.failure(.userCreateError))
                    } else {
                        completion(.success(()))
                    }
                }
        } catch {
            print("Encoding error:", error)
            completion(.failure(.unknownError))
        }
    }
    
    // MARK: - Create Public User
    func createPublicUser(_ user: User, completion: @escaping (Result<Void, DZError>) -> Void) {
        
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
                        completion(.failure(.userCreateError))
                    } else {
                        completion(.success(()))
                    }
                }
        } catch {
            print("Encoding error:", error)
            completion(.failure(.unknownError))
        }
    }
    
    // MARK: - Check Username Availability
    func checkUsernameExists(_ username: String, completion: @escaping (Result<Void, DZError>) -> Void) {
        
        db.collection("publicUsers")
            .whereField("username", isEqualTo: username.lowercased())
            .getDocuments { snapshot, error in
                
                if let error = error {
                    print("Username check error:", error)
                    completion(.failure(.networkError))
                    return
                }
                
                if let documents = snapshot?.documents, !documents.isEmpty {
                    completion(.failure(.usernameTaken))  // username already exists
                } else {
                    completion(.success(())) // username is available
                }
            }
    }
    
    // MARK: - Fetch All Public Users
    func fetchAllUsers(completion: @escaping (Result<[PublicUser], DZError>) -> Void) {
        db.collection("publicUsers")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Fetch users error:", error)
                    completion(.failure(.loadUsersError))
                    return
                }
                
                let users: [PublicUser] = snapshot?.documents.compactMap { document in
                    return try? document.data(as: PublicUser.self)
                } ?? []
                
                completion(.success(users))
            }
    }
    
    func searchUsers(usernamePrefix: String, lastDocument: DocumentSnapshot? = nil, completion: @escaping (Result<([PublicUser], DocumentSnapshot?), DZError>) -> Void) {
        var query = db.collection("publicUsers")
            .order(by: "username")
            .whereField("username", isGreaterThanOrEqualTo: usernamePrefix)
            .whereField("username", isLessThan: usernamePrefix + "\u{f8ff}")
            .limit(to: 20)
        
        if let lastDocument = lastDocument {
            query = query.start(afterDocument: lastDocument)
        }
        
        query.getDocuments { snapshot, error in
            if let _ = error {
                completion(.failure(.networkError))
                return
            }
            
            let users = snapshot?.documents.compactMap {
                try? $0.data(as: PublicUser.self)
            } ?? []
            
            completion(.success((users, snapshot?.documents.last)))
        }
    }
}
