//
//  MovieDetailsViewModel.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/24/26.
//
import Foundation

protocol MovieDetailsViewModelProtocol: AnyObject {
    func fetchMovies(completion: @escaping() -> Void)
    func numberOfMovies()-> Int
    func movie(at index: Int) -> Movie

    
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    

    private var movies: [Movie] = []
    
    
    // MARK: - API Call
    
    func fetchMovies(completion: @escaping() -> Void) {
        
        NetworkManager.shared.fetchDataFrom(serverUrl: APIConstants.sharePathUrl()){
            [weak self] fetchedMovies in
            defer {
                completion()
            }
            guard let self = self else { return }
            self.movies = fetchedMovies
            completion()
        }
    }
// MARK:- Helper Method
    
func numberOfMovies() -> Int {
            return movies.count
        }
func movie(at index: Int) -> Movie {
            return movies[index]
        }
}

