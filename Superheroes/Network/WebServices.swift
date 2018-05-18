//
//  WebServices.swift
//  Superheroes
//
//  Created by Borja Álvaro González Jurado on 22/04/2018.
//  Copyright © 2018 Borja González Jurado. All rights reserved.
//

import Foundation
import UIKit

class WebServices {
    
    func loadSuperheroes(completionHandler: @escaping (Result<[Superheroe]>) -> ()) {
        
        let url = "https://api.myjson.com/bins/bvyob"
        
        var superheroes = [Superheroe]()
        
        guard let requestUrl = URL(string: url) else { return }
        let request = URLRequest(url: requestUrl)
        
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            
            if let responseError = error {
                return completionHandler(Result.Failure(ErrorManager.ErrorType.networkError(responseError.localizedDescription)))
            }
            
            guard let responseData = data else {
                return completionHandler(Result.Failure(ErrorManager.ErrorType.dataError("Error in loadSuperheroes func: did not receive data")))
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                
                guard let dictionary = json as? [String : Any],
                    let superheroesDictionary = dictionary["superheroes"] as? [[String : Any]] else {
                        return completionHandler(Result.Failure(ErrorManager.ErrorType.dataError("Error in loadSuperheroes func: error trying to extract superheroes array")))
                }
                
                superheroes = superheroesDictionary.compactMap({ superheroeDictionary -> Superheroe? in
                    Superheroe.init(dictionary: superheroeDictionary)
                })
                
                DispatchQueue.main.async {
                    completionHandler(Result.Success(superheroes))
                }
            } catch {
                return completionHandler(Result.Failure(ErrorManager.ErrorType.parsingJSONError("Error in loadSuperheroes func: error trying to convert data to JSON")))
            }
            }.resume()
    }
}
