//
//  SuperheroeListViewModel.swift
//  Superheroes
//
//  Created by Borja Álvaro González Jurado on 22/04/2018.
//  Copyright © 2018 Borja González Jurado. All rights reserved.
//

import Foundation

class SuperheroesListViewModel {
    
    private var webServices: WebServices
    private (set) var superheroeListViewModel = [SuperheroeCellViewModel]()
    private (set) var superheroes = [Superheroe]()
    private var completionHandler: () -> () = {  }
    
    init(webServices: WebServices, completionHandler: @escaping () -> ()) {
        
        self.webServices = webServices
        self.completionHandler = completionHandler
        self.fetchSuperheroes()
    }
}

extension SuperheroesListViewModel {
    
    private func fetchSuperheroes() {
        
        webServices.loadSuperheroes { result in
            
            switch result {
            case let .Success(superheroes):
                self.superheroes = superheroes
                self.populateSuperheroes()
            case let .Failure(error):
                ErrorManager.handleError(error, className: String(describing: SuperheroesListViewModel.self), message: error.localizedDescription)
            }
        }
    }
    
    private func populateSuperheroes() {
        
        superheroeListViewModel = self.superheroes.map({ superheroe in
            SuperheroeCellViewModel.init(superheroe)
        })
        
        completionHandler()
    }
    
    func superheroeAt(index :Int) -> SuperheroeDetailViewModel {
        
        return SuperheroeDetailViewModel.init(self.superheroes[index])
    }
}

struct SuperheroeCellViewModel {
    
    let name: String
    let photo: String
    
    init(_ superheroe: Superheroe) {
        
        self.name = superheroe.name
        self.photo = superheroe.photo
    }
}
