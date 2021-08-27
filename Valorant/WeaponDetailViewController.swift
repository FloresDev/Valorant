
import UIKit

class WeaponDetailViewController: UIViewController {
    
    @IBOutlet weak var weaponImage: UIImageView!
    @IBOutlet weak var weponName: UILabel!
    @IBOutlet weak var weaponName03: UILabel!
    @IBOutlet weak var weaponName06: UILabel!
    @IBOutlet weak var weaponName07: UILabel!
    @IBOutlet weak var weaponNamePrinc: UILabel!
    @IBOutlet weak var weaponTypeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var fireModeLabel: UILabel!
    @IBOutlet weak var penetrationLabel: UILabel!
    @IBOutlet weak var statsWeaponView: UIView!
    
    var connection = Connection()
    var weaponuuid: String?
    var loader = Loading()
    let spanishLanguage = "language=es-ES"
    var weapon: WeaponDow?
    var type = ""
    var fireMode = ""
    var penetration = ""
    var cost = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statsWeaponView.layer.cornerRadius = 5
        statsWeaponView.layer.borderWidth = 3
        statsWeaponView.layer.borderColor = #colorLiteral(red: 0.9240000248, green: 0.3059999943, blue: 0.3289999962, alpha: 1)
        
        connection.getWeapon(language: spanishLanguage, uuid: weaponuuid!) { [self] (weapon) in
            if let weapon = weapon {
                
                if weapon.data?.weaponStats?.fireMode == "EWeaponFireModeDisplayType::SemiAutomatic"{
                    fireMode = "Semi"
                }else{
                    fireMode = "Auto"
                }
                
                if weapon.data?.weaponStats?.wallPenetration == "EWallPenetrationDisplayType::High"{
                    penetration = "ALTA"
                }else{
                    penetration = "BAJA"
                }
   
                DispatchQueue.main.async {
                    
                    weaponName03.text = weapon.data?.displayName
                    weaponName06.text = weapon.data?.displayName
                    weaponName07.text = weapon.data?.displayName
                    weponName.text = weapon.data?.displayName
                    weaponNamePrinc.text = weapon.data?.displayName
                    weaponTypeLabel.text = type
                    fireModeLabel.text = fireMode
                    penetrationLabel.text = penetration
                    
                    if cost != 0{
                        
                    costLabel.text = String(cost)
                        
                    }else{
                        costLabel.text = "Gratis"
                    }
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
