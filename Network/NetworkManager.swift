//
//  NetworkManager.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/24/26.
//

import UIKit

protocol NetworkProtocol {
    func fetchDataFrom(serverUrl: String, completion: @escaping (NetworkState) -> Void )
}

final class NetworkManager: NetworkProtocol, Sendable {
    
    // MARK: - Singleton
    
    static let shared: NetworkManager = NetworkManager()
    private init (){}
    
    // MARK: - Fetch Data
    //    step: 5   NetworkManager fetches API data
    //    This function is actual API call:
    func fetchDataFrom(
        serverUrl: String,
        completion: @escaping (NetworkState) -> Void
    ){
        completion(.loading)
        //    This line creates URL:
        guard let serverURL = URL(string: serverUrl) else {
            print("Server URL is invalid")
            completion(.failure(error:.invalidURL))
            return
        }
        
        let urlRequest = URLRequest(url: serverURL)
        let urlSession = URLSession.shared
        //        This line starts URLSession:
        urlSession.dataTask(with: urlRequest) { data, response, error in
            
            // TODO: - code goes here
            if error != nil {
                print("Unable to fetch data from server, \(error!.localizedDescription)")
                completion(.failure(error: .serverError))
                return
            }
            
            guard let receivedData = data else {
                print("Fetched data is nil")
                completion(.failure(error: .noData))
                return
            }
            
            //MARK: -  Parse  Data into Model
            
            do {
                //                This line decodes JSON:
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: receivedData)
                print(movieResponse.results)
                //                This line sends data back to ViewModel:
                completion(.Sucessful(data:movieResponse.results))
            } catch {
                print("Unable to parse the data into the model", error)
                completion(.failure(error: .decodingError))
            }
        }
        .resume()
    }
}


