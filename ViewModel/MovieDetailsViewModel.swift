//
//  MovieDetailsViewModel.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/24/26.
//
import Foundation

protocol MovieDetailsViewModelProtocol: AnyObject {
    var completionHandler: ((String?)-> Void)? {get set}
    func fetchMovies()
    func numberOfMovies() -> Int
    func movie(at index: Int) -> Movie
    func SearchMovie(with searchText: String)
}

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    // MARK: - Properties
    
    var completionHandler: ((String?)-> Void)?
    var networkManager : NetworkProtocol?
    private var movies: [Movie] = []
    private var filteredMovies: [Movie] = []
    
    init(networkManager: NetworkProtocol = NetworkManager.shared){
        self.networkManager = networkManager
    }
    
    // MARK: - API Call
//    step : 4 ViewModel fetchMovies calls NetworkManager
    func fetchMovies() {
        let manager = networkManager ??  NetworkManager.shared
        manager.fetchDataFrom(serverUrl: APIConstants.sharePathUrl()) { [weak self] fetchedMovies in
            switch fetchedMovies {
            case .loading:
                self?.completionHandler?(nil)
            case.Sucessful(data: let fetchedMovies):
                self?.movies = fetchedMovies.results
                self?.filteredMovies = fetchedMovies.results
                self?.completionHandler?("")
            case .failure(let error):
                self?.completionHandler?(error.localizedDescription)
            }
        }
    }
//    private func handleFailure(error: NetworkError) {
//        switch error {
//
//        case .decodingError:
//            print("Decoding error")
//        case .invalidURL:
//            print("Invalid URL")
//        case .noData:
//            print("No data found")
//        case .serverError:
//            print("Server error")
//        case .noInternet:
//        print("No internet connection")
//        }
//        
//    }
    
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

