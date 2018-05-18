//
//  CustomImageView.swift
//  Superheroes
//
//  Created by Borja Álvaro González Jurado on 30/04/2018.
//  Copyright © 2018 Borja González Jurado. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func fetchImage(url: String) {
        
        image = nil
        
        imageUrlString = url
        
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            image = cachedImage
            return
        }
        
        guard let imageURL = URL(string: url) else {
            return
        }
        
        downloadImage(url: imageURL) { (result) in
            
            switch result {
            case let .Success(image):
                if self.imageUrlString == url {
                    self.image = image
                }
                
                imageCache.setObject(image, forKey: url as NSString)
            case let .Failure(error):
                ErrorManager.handleError(error, className: String(describing: CustomImageView.self), message: error.localizedDescription)
            }
        }
    }
    
    private func downloadImage(url: URL, completionHandler: @escaping (Result<UIImage>) -> ()) {
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            
            if let responseError = error {
                return completionHandler(Result.Failure(ErrorManager.ErrorType.networkError(responseError.localizedDescription)))
            }
            
            guard let responseData = data,
                let image = UIImage(data: responseData) else {
                    return completionHandler(Result.Failure(ErrorManager.ErrorType.dataError("Error in downloadImage func: did not receive data")))
            }
            
            DispatchQueue.main.async {
                completionHandler(Result.Success(image))
            }
            }.resume()
    }
}
