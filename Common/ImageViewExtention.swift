//
//  ImageViewExtention.swift
//  MovieProject
//
//  Created by Naga Rajitha Bhogadi on 6/24/26.
//

import UIKit

extension UIImageView {
    func fetchDataFrom(serverUrl: String) {
        guard let serverURL = URL(string: serverUrl) else {
            print("Server URL is invalid")
            // we need to return something
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
            
            /// data is of DATA , which is serialized Object , it contains data in machine readable format
            /// To get the swift post array , we need to convert data object to model
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




