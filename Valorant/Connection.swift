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
    
    // Función para obtener el listado completo de personajes
    func getPersons(language: String, completion: @escaping(_ persons: Persons?) -> Void) {
        guard let url = URL(string: "\(baseURLString)\(language)") else {
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
}
