//
//  Connection.swift
//  Valorant
//
//  Created by daniel on 05/04/2021.
//

import Foundation
import UIKit

class Connection {
    

    let baseURLString = "https://valorant-api.com/v1/agents?"
    let baseURLString2 = "https://valorant-api.com/v1/weapons?"
    let baseURLString3 = "https://valorant-api.com/v1/weapons/"
    

    let baseURLString = "https://valorant-api.com/v1/"
    let agents = "agents?"
    let maps = "maps"

    
    // Función para obtener el listado completo de personajes
    func getPersons(language: String, completion: @escaping(_ persons: Persons?) -> Void) {
        guard let url = URL(string: "\(baseURLString)\(agents)\(language)") else {
            completion(nil)
            return
        }
        
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: url) {data, response, error in
            // Si no se produce un error y además puede obtener datos
            if error == nil, let data = data {
                let persons = Persons(withJSONData: data)
                completion(persons)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    // Función para obtener el listado completo de personajes
    func getWeapons(language: String, completion: @escaping(_ weapons: Weapons?) -> Void) {
        guard let url = URL(string: "\(baseURLString2)\(language)") else {
            completion(nil)
            return
        }
        
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: url) {data, response, error in
            // Si no se produce un error y además puede obtener datos
            if error == nil, let data = data {
                let weapons = Weapons(withJSONData: data)
                completion(weapons)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func getWeapon(language: String, uuid: String, completion: @escaping(_ weapons: WeaponDow?) -> Void) {
        guard let url = URL(string: "\(baseURLString3)\(uuid)?\(language)") else {
            completion(nil)
            return
        }
        
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: url) {data, response, error in
            // Si no se produce un error y además puede obtener datos
            if error == nil, let data = data {
                let weapon = WeaponDow(withJSONData: data)
                completion(weapon)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    // Función para obtener las imágenes
    func getImage(urlString: String, completion: @escaping(_ image: UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: url) {data, response, error in
            // Si no se produce un error y además puede obtener datos
            if error == nil, let data = data {
                let image = UIImage(data: data)
                completion(image)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    // Función para obtener el listado completo de mapas
    func getMaps(completion: @escaping(_ maps: Maps?) -> Void) {
        guard let url = URL(string: "\(baseURLString)\(maps)") else {
            completion(nil)
            return
        }
        
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: url) {data, response, error in
            // Si no se produce un error y además puede obtener datos
            if error == nil, let data = data {
                let maps = Maps(withJSONData: data)
                completion(maps)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }
}
