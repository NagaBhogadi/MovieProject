//
//  MpvieDisplayPolicy.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 7/1/26.
//
import Foundation

struct MovieDisplayPolicy {
    static let featuredThreshold = 5.5

    static func isFeatured(voteCount: Double) -> Bool {
        voteCount >= featuredThreshold
    }
}
