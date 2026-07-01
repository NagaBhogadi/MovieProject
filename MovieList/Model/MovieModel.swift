//
//  Model.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/24/26.
//

import Foundation

// MARK: - Movie Response

struct MovieResponse: Codable {
    let results: [Movie]
}

// MARK: - Movie Model

struct Movie: Codable {
    
    // MARK: - Properties
    
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Double
    let popularity: Double
    let originalLanguage: String
    
    // MARK: - Coding Keys

    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity
        case originalLanguage = "original_language"
    }
}
