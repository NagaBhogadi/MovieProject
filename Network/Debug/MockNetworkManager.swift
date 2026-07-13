//
//  MockNetworkManager.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/25/26.
//

import Foundation

//// MARK: - Mock Network Manager
//
//final class MockNetworkManager:NetworkProtocol {
//    
//    // MARK: - Singleton
//    
//    static let shared = MockNetworkManager()
//    
//    private init() {}
//    
//    // MARK: - Fetch Mock Data
//    
//    func fetchDataFrom(
//        serverUrl: String,
//        completion: @escaping (NetworkState) -> Void
//    ) {
//        let movie = Movie(
//            title: "Movie",
//            overview: "Overview",
//            posterPath: "poster.jpg",
//            backdropPath: "backdrop.jpg",
//            releaseDate: "2026-06-25",
//            voteAverage: 8.5,
//            voteCount: 100,
//            popularity: 99.0,
//            originalLanguage: "en"
//        )
//        completion(.Sucessful(data: MovieResponse))
//    }
//}
