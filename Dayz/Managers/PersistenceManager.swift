//
//  PersistenceManager.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 19.12.2025.
//

import Foundation

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let recentlyVisitedProfiles = "recents"
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
}
