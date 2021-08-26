//
//  WeaponDetailViewController.swift
//  Valorant
//
//  Created by Jorge Suarez Calafat on 26/8/21.
//
//cambio hecho por Koke
import UIKit

class WeaponDetailViewController: UIViewController {

    @IBOutlet weak var weaponImage: UIImageView!
    @IBOutlet weak var weponName: UILabel!

    @IBOutlet weak var weaponName03: UILabel!
  
    @IBOutlet weak var weaponName06: UILabel!
    @IBOutlet weak var weaponName07: UILabel!
    @IBOutlet weak var weaponNamePrinc: UILabel!
    @IBOutlet weak var weaponTypeLabel: UILabel!
    
    var connection = Connection()
    var weaponuuid: String?
    var loader = Loading()
    let spanishLanguage = "language=es-ES"
    var weapon: WeaponDow?
    // Cambio hecho por Dani
    // Cambio 2 hecho por Dani
    
    override func viewDidLoad() {
        super.viewDidLoad()

        connection.getWeapon(language: spanishLanguage, uuid: weaponuuid!) { [self] (weapon) in
            if let weapon = weapon {
               
                DispatchQueue.main.async {
                   
                    
                    weaponName03.text = weapon.data?.displayName
                   
                    weaponName06.text = weapon.data?.displayName
                    weaponName07.text = weapon.data?.displayName
                    weponName.text = weapon.data?.displayName
                    weaponNamePrinc.text = weapon.data?.displayName
                    weaponTypeLabel.text = weapon.data?.category
                }

                
            
            
                connection.getImage(urlString: (weapon.data?.displayIcon)!) {[self] (image) in
                if let image = image {
                    DispatchQueue.main.async {
                        weaponImage.image = image
                      
                    }

                }
    }
              

            }
       
           
}
        
       
}
    
}
