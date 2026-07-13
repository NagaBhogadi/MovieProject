//
//  ImageCacheManager.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 7/8/26.
//

import UIKit

final class ImageCacheManager{
    static let shared = ImageCacheManager()
    private init() {}
    private let cache = NSCache<NSString, UIImage>()
    func getImage(forKey key: String) -> UIImage? {
            return cache.object(forKey: key as NSString)
        }
        
        func saveImage(_ image: UIImage, forKey key: String) {
            cache.setObject(image, forKey: key as NSString)
        }
}

