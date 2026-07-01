//
//  Error.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 7/1/26.
//
enum NetworkError: String ,Error {
    case noInternet
    case invalidURL
    case serverError
    case decodingError
    case noData
}
enum NetworkState {
    case loading
    case Sucessful (data:[Movie])
    case failure(error: NetworkError)
}
