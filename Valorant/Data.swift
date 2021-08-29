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

class Maps: Mappable {
    
    var data: [Map]?
}

class Map: Mappable {
    
    var displayName: String?
    var coordinates: String?
    var displayIcon: String?
    var splash: String?
    var artImage: UIImage?
    var mapIcon: UIImage?
    
    // OJO EL CODING KEY ES NECESARIO PARA METER UNA IMAGEN EN LA CLASE MAPPABLE
    // DEBERÁ CONTEMPLAR TODAS LAS VARIABLES MENOS LA DE LA IMAGEN
    private enum CodingKeys: String, CodingKey {
        
        case displayName
        case coordinates
        case displayIcon
        case splash
    }
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
    var weaponStats: WeaponStats?
    var skins: [Skins?]
    
    // OJO EL CODING KEY ES NECESARIO PARA METER UNA IMAGEN EN LA CLASE MAPPABLE
    // DEBERÁ CONTEMPLAR TODAS LAS VARIABLES MENOS LA DE LA IMAGEN
    private enum CodingKeys: String, CodingKey {
        case uuid
        case displayName
        case category
        case displayIcon
        case shopData
        case weaponStats
        case skins
       
    }
}
    
    class ShopData: Mappable{
        var cost: Int?
    }
    
    class WeaponStats: Mappable{
        var wallPenetration: String?
        var fireMode: String?
        var fireRate: Float?
        var runSpeedMultiplier: Float?
        var reloadTimeSeconds: Float?
        var magazineSize: Float?
        var firstBulletAccuracy: Float?
        var damageRanges: [DamageRanges?]
        var adsStats: AdsStats?
    }
    
    class DamageRanges: Mappable{
        var headDamage: Float
        var bodyDamage: Float
        var legDamage: Float
    }
    
    class AdsStats: Mappable{
        var zoomMultiplier: Float?
        var fireRate: Float?
        var runSpeedMultiplier: Float?
        var burstCount: Float?
        var firstBulletAccuracy: Float?
    }
    
    class Skins: Mappable {
        var uuid: String?
        var displayName: String?
        var displayIcon: String?
        var image: UIImage?
        var chromas: [Chromas?]
        
        private enum CodingKeys: String, CodingKey {
            case uuid
            case displayName
            case displayIcon
            case chromas
        }
    }
    
    class Chromas: Mappable {
        var uuid: String?
        var displayName: String?
        var displayIcon: String?
        var swatch: String?
        var image: UIImage?
        
        private enum CodingKeys: String, CodingKey {
            case uuid
            case displayName
            case displayIcon
            case swatch
        }
    }

class Cards: Mappable {
    var data: [Card]?
}

class CardOlnly: Mappable {
    var data: Card?
}

class Card: Mappable {
    
    var uuid: String?
    var displayName: String?
    var displayIcon: String?
    var largeArt: String?
    var image: UIImage?
    
    // OJO EL CODING KEY ES NECESARIO PARA METER UNA IMAGEN EN LA CLASE MAPPABLE
    // DEBERÁ CONTEMPLAR TODAS LAS VARIABLES MENOS LA DE LA IMAGEN
    private enum CodingKeys: String, CodingKey {
        case uuid
        case displayName
        case displayIcon
        case largeArt
       
    }
    
}

class Sprays: Mappable{
    var data:[Spray]?
}

class SprayOnly: Mappable {
    var data: Spray?
}

class Spray: Mappable {
    var uuid: String?
    var displayName: String?
    var displayIcon: String?
    var fullIcon: String?
    var fullTransparentIcon: String?
    var image: UIImage?
    
    private enum CodingKeys: String, CodingKey {
        case uuid
        case displayName
        case displayIcon
        case fullIcon
        case fullTransparentIcon
       
    }
}


