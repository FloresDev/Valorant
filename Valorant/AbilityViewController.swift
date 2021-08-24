//
//  AbilityViewController.swift
//  Valorant
//
//  Created by daniel on 08/04/2021.
//

import UIKit

class AbilityViewController: UIViewController {
    
    @IBOutlet weak var iconImageView: UIImageView!
    

    
    @IBOutlet weak var abilityNameLabel: UILabel!
    @IBOutlet weak var abilitySlotLabel: UILabel!
    
    @IBOutlet weak var abilityDescriptionLabel: UILabel!
    
    var ability: Ability?
    var imagePerson: UIImage?
    var urlImagePerson: String?
    var connection = Connection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        abilityNameLabel.text = ability?.displayName
        abilitySlotLabel.text = ability?.slot
        abilityDescriptionLabel.text = ability?.description

        
        connection.getImage(urlString: ability!.displayIcon!) { (image) in
            if let image = image {
                DispatchQueue.main.async { [self] in
                    iconImageView.image = image
                }
            }
        }
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
