//
//  Data.swift
//  Valorant
//
//  Created by daniel on 05/04/2021.
//

import Foundation
import UIKit


class Persons: Mappable {
    
    var data: [Person]?
}

class Person: Mappable {
    
    var uuid: String?
    var displayName: String?
    var description: String?
    var displayIcon: String?
    var bustPortrait: String?
    var fullPortrait: String?
    var role: Role?
    var abilities: [Ability]?
    var image: UIImage?
    
    // OJO EL CODING KEY ES NECESARIO PARA METER UNA IMAGEN EN LA CLASE MAPPABLE
    // DEBERÁ CONTEMPLAR TODAS LAS VARIABLES MENOS LA DE LA IMAGEN
    private enum CodingKeys: String, CodingKey {
        case uuid
        case displayName
        case description
        case displayIcon
        case bustPortrait
        case fullPortrait
        case role
        case abilities
    }
    
}

class Role: Mappable {
    var displayName: String?
    var description: String?
    var displayIcon: String?
}

class Ability: Mappable {
    
    var slot: String?
    var displayName: String?
    var description: String?
    var displayIcon: String?
    
}

class Weapons: Mappable {
    
    var data: [Weapon]?
}

class WeaponDow: Mappable{
    var data: Weapon?
}

class Weapon: Mappable {
    
    var uuid: String?
    var displayName: String?
    var category: String?
    var displayIcon: String?
    var image: UIImage?
    var shopData: ShopData?
    
    // OJO EL CODING KEY ES NECESARIO PARA METER UNA IMAGEN EN LA CLASE MAPPABLE
    // DEBERÁ CONTEMPLAR TODAS LAS VARIABLES MENOS LA DE LA IMAGEN
    private enum CodingKeys: String, CodingKey {
        case uuid
        case displayName
        case category
        case displayIcon
        case shopData
       
    }
    
    class ShopData: Mappable{
        var cost: Int?
    }
    
}

