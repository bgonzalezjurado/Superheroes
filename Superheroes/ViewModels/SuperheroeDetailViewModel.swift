//
//  SuperheroeDetailViewModel.swift
//  Superheroes
//
//  Created by Borja Álvaro González Jurado on 25/04/2018.
//  Copyright © 2018 Borja González Jurado. All rights reserved.
//

import Foundation

struct SuperheroeDetailViewModel {
    
    let name: String
    let photo: String
    let realName: String
    let height: String
    let power: String
    let abilities: String
    let groups: String
    
    init(_ superheroe: Superheroe) {
        
        self.name = superheroe.name
        self.photo = superheroe.photo
        self.realName = superheroe.realName
        self.height = superheroe.height
        self.power = superheroe.power
        self.abilities = superheroe.abilities
        self.groups = superheroe.groups
    }
}
