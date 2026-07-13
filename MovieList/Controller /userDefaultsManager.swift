//
//  userDefaultsManager.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 7/7/26.
//

import Foundation

final class UserDefaultsManager {

    static let shared = UserDefaultsManager()

    private init() {}

    private let favoritesKey = "favorite_movies"

    // Save
    func saveFavorites(_ ids: [Int]) {
        UserDefaults.standard.set(ids, forKey: favoritesKey)
    }

    // Read
    func fetchFavorites() -> [Int] {
        return UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
    }

    // Add
    func addFavorite(id: Int) {
        var ids = fetchFavorites()

        if !ids.contains(id) {
            ids.append(id)
            saveFavorites(ids)
        }
    }

    // Remove
    func removeFavorite(id: Int) {
        var ids = fetchFavorites()
        ids.removeAll { $0 == id }
        saveFavorites(ids)
    }

    // Check
    func isFavorite(id: Int) -> Bool {
        return fetchFavorites().contains(id)
    }
}
