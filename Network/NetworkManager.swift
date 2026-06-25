//
//  NetworkManager.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/24/26.
//

import UIKit

protocol NetworkProtocol {
    func fetchDataFrom(serverUrl: String, completion: @escaping ([Movie]) -> Void )
}

final class NetworkManager: NetworkProtocol, Sendable {
    
    // MARK: - Singleton
    
    static let shared: NetworkManager = NetworkManager()
    private init (){}
    
    // MARK: - Fetch Data
    
    func fetchDataFrom(
        serverUrl: String,
        completion: @escaping  ([Movie]) -> Void
    ){
        guard let serverURL = URL(string: serverUrl) else {
            print("Server URL is invalid")
            completion([])
            return
        }
        
        let urlRequest = URLRequest(url: serverURL)
        let urlSession = URLSession.shared
        urlSession.dataTask(with: urlRequest) { data, response, error in
            
            // TODO: - code goes here
            if error != nil {
                print("Unable to fetch data from server, \(error!.localizedDescription)")
                completion([])
                return
            }
            
            guard let receivedData = data else {
                print("Fetched data is nil")
                completion([])
                return
            }
            
            //MARK: -  Parse  Data into Model
            
            do {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: receivedData)
                print(movieResponse.results)
                completion(movieResponse.results)
            } catch {
                print("Unable to parse the data into the model", error)
                completion([])
            }
        }
        .resume()
    }
}


