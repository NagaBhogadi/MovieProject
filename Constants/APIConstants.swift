//
//  APIConstants.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/24/26.
//

import Foundation

struct APIConstants {
    
    // MARK: - API URLs
    
    static let apiURLPath = "https://api.themoviedb.org/3/discover/movie?api_key="
    static let imageURLPath = "https://image.tmdb.org/t/p/w500"
    
    // MARK: - API Key
    
    static let APIKEY = "c91ed3a7a344459eccad9687acf0d07e"
    //  static let APIKEY = ""
    
    // MARK: - Helper Methods
    
    static func sharePathUrl() -> String {
        return apiURLPath + APIKEY
    }
    
    static func shareImagePathUrl() -> String {
        return imageURLPath
    }
}
