//
//  Mappable.swift
//  Pokemon_Taller
//
//  Created by daniel on 24/03/2021.
//

import Foundation


// Protocolo Mappable para mapear las propiedades

// Extiende de Codable

protocol Mappable: Codable {
    
    // Método de inicialización que puede devolver un nulo
    // Recibe un data que tambiénm puede ser un nulo
    init?(withJSONData: Data?)
}

/*
 Extensión para que el objeto que implemente la interfaz Mappable
 tenga este inicizalizador
 */
extension Mappable {
    
    init?(withJSONData: Data?) {
        
        // Mediante el guard comprobamos que el JSONData no sea nulo
        // en caso de que lo sea devolvemos un nulo
        guard let data = withJSONData else {return nil}
        
        // Si no es nulo
        do {
            // El objeto que implemente este protocolo va a ser igual
            // a una decodificación de JSON de los datos acoplándolos al
            // objeto al que estamos haciendo inicialización
            self = try JSONDecoder().decode(Self.self, from: data)
        } catch {
            // Si no se pude decodificar por lo que sea devclemos un nil
            return nil
        }
    }
}
