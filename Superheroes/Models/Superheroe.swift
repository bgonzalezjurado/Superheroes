//
//  Superheroe.swift
//  Superheroes
//
//  Created by Borja Álvaro González Jurado on 22/04/2018.
//  Copyright © 2018 Borja González Jurado. All rights reserved.
//

import Foundation

struct Superheroe {
    
    let name: String
    let photo: String
    let realName: String
    let height: String
    let power: String
    let abilities: String
    let groups: String
    
    init?(dictionary: [String : Any]) {
        
        guard let name = dictionary["name"] as? String,
            let photo = dictionary["photo"] as? String,
            let realName = dictionary["realName"] as? String,
            let height = dictionary["height"] as? String,
            let power = dictionary["power"] as? String,
            let abilities = dictionary["abilities"] as? String,
            let groups = dictionary["groups"] as? String else {
                return nil
        }
        
        self.name = name
        self.photo = photo
        self.realName = realName
        self.height = height
        self.power = power
        self.abilities = abilities
        self.groups = groups
    }
}
