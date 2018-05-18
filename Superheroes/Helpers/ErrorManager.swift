//
//  ErrorManager.swift
//  Superheroes
//
//  Created by Borja Álvaro González Jurado on 01/05/2018.
//  Copyright © 2018 Borja González Jurado. All rights reserved.
//

import Foundation

enum Result<T> {
    case Success(T)
    case Failure(ErrorManager.ErrorType)
}

class ErrorManager {
    
    enum ErrorType: Error {
        case dataError(String)
        case networkError(String)
        case parsingJSONError(String)
        case storyBoardError(String)
        case unknowError(String)
    }
    
    static func handleError(_ error: ErrorType, className: String, message: String) {
        
        print("Throwed error in class: \(className)\n - Type: \(error)\n - Message: \(message)")
    }
}
