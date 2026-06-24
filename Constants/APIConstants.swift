//
//  APIConstants.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/24/26.
//

import Foundation
struct APIConstants {
    static let apiURLPath = "https://api.themoviedb.org/3/discover/movie?api_key="
    static let imageURLPath = "https://image.tmdb.org/t/p/w500"
    static let APIKEY = "c91ed3a7a344459eccad9687acf0d07e"
    static func sharePathUrl() -> String {
        return apiURLPath + APIKEY
    }
    static func shareImagePathUrl() -> String {
        return imageURLPath
    }
}
