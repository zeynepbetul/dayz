//
//  PersistenceManager.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 19.12.2025.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let recentlyVisitedProfiles = "recents"
    }
    
    static func updateWith(favorite: PublicUser, actionType: PersistenceActionType, completed: @escaping (DZError?) -> Void) {
        retrieveRecentlyVisitedProfiles { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        // completed(.alreadyInFavorites)
                        return
                    }
                    retrievedFavorites.append(favorite)
                case .remove:
                    retrievedFavorites.removeAll { $0.username == favorite.username }
                }
                
                completed(save(favorites: favorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveRecentlyVisitedProfiles(completed: @escaping (Result<[PublicUser], DZError>) -> Void) {
        guard let recentsData = defaults.object(forKey: Keys.recentlyVisitedProfiles) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let profiles = try decoder.decode([PublicUser].self, from: recentsData)
            completed(.success(profiles))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [PublicUser]) ->DZError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.recentlyVisitedProfiles)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
