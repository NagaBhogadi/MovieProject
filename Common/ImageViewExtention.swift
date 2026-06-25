//
//  ImageViewExtention.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/24/26.
//

import UIKit

extension UIImageView {
    
    // MARK: - Fetch Image
    
    func fetchDataFrom(serverUrl: String) {
        guard let serverURL = URL(string: serverUrl) else {
            print("Server URL is invalid")
            return self.image = UIImage(systemName: "heart.fill")
        }
        
        let urlRequest = URLRequest(url: serverURL)
        let urlSession = URLSession.shared
        urlSession.dataTask(with: urlRequest) { data, response, error in
            // TODO: - code goes here
            
            if error != nil {
                return self.image = UIImage(systemName: "heart.fill")
            }
            guard let receivedData = data else {
                return self.image = UIImage(systemName: "heart.fill")
            }
            // MARK: - Update Image
            
            DispatchQueue.main.async {[weak self] in
                let downlodedImage = UIImage(data: receivedData)
                self?.image = downlodedImage
                self?.image = UIImage(data: receivedData)
                print(downlodedImage)
            }
        }
        .resume()
    }
}




