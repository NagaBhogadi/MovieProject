//
//  FileManagerHelper.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 7/7/26.
//
import Foundation

final class FileManagerHelper {
    
    static let shared = FileManagerHelper()
    private init() {}
    
    private let fileName = "favorite_movies.json"
    
    private var fileURL: URL {
        let documentsDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
        
        return documentsDirectory.appendingPathComponent(fileName)
        
    }
    
    func saveFavoriteMovieIds(_ ids: [Int]) {
        do {
            let data = try JSONEncoder().encode(ids)
            try data.write(to: fileURL)
            print("Saved to file path:", fileURL.path)
        } catch {
            print("Save error:", error.localizedDescription)
        }
    }
    
    func fetchFavoriteMovieIds() -> [Int] {
        do {
            let data = try Data(contentsOf: fileURL)
            let ids = try JSONDecoder().decode([Int].self, from: data)
            return ids
        } catch {
            return []
        }
    }
    
    func addFavorite(id: Int) {
        var ids = fetchFavoriteMovieIds()
        
        if !ids.contains(id) {
            ids.append(id)
            saveFavoriteMovieIds(ids)
        }
    }
    
    func removeFavorite(id: Int) {
        var ids = fetchFavoriteMovieIds()
        ids.removeAll { $0 == id }
        saveFavoriteMovieIds(ids)
    }
    
    func isFavorite(id: Int) -> Bool {
        return fetchFavoriteMovieIds().contains(id)
    }
    
}
