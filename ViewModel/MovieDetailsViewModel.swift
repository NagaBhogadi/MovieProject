//
//  MovieDetailsViewModel.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/24/26.
//
import Foundation

protocol MovieDetailsViewModelProtocol: AnyObject {
    func fetchMovies(completion: @escaping () -> Void)
    func numberOfMovies() -> Int
    func movie(at index: Int) -> Movie
    func SearchMovie(with searchText: String)
}

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    // MARK: - Properties
    
    private var movies: [Movie] = []
    private var filteredMovies: [Movie] = []
    
    // MARK: - API Call
    
    func fetchMovies(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchDataFrom(serverUrl: APIConstants.sharePathUrl()) { [weak self] fetchedMovies in
            self?.movies = fetchedMovies
            self?.filteredMovies = fetchedMovies
            completion()
        }
    }
    
    // MARK: - Helper Methods
    
    func numberOfMovies() -> Int {
        return filteredMovies.count
    }
    func movie(at index: Int) -> Movie {
        return filteredMovies[index]
    }
    
//    MARK: - Search Bar Function
    
     func SearchMovie(with searchText: String) {
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter { movie in movie.title.localizedStandardContains(searchText)}
        }
    }
    
}

