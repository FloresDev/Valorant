
import UIKit

class WeaponDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
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
    @IBOutlet weak var FireRateLabel: UILabel!
    @IBOutlet weak var multiSpeedLabel: UILabel!
    @IBOutlet weak var reloadTimeLabel: UILabel!
    @IBOutlet weak var magazineLabel: UILabel!
    @IBOutlet weak var firstBulletAccLabel: UILabel!
    @IBOutlet weak var rangeDamageView: UIView!
    @IBOutlet weak var headDama01Label: UILabel!
    @IBOutlet weak var headDama02Label: UILabel!
    @IBOutlet weak var bodyDama01Label: UILabel!
    @IBOutlet weak var bodyDama02Label: UILabel!
    @IBOutlet weak var legDama01Label: UILabel!
    @IBOutlet weak var legDama02Label: UILabel!
    @IBOutlet weak var FireRateADSLabel: UILabel!
    @IBOutlet weak var multiSpeedADSLabel: UILabel!
    @IBOutlet weak var multiZoomADSLabel: UILabel!
    @IBOutlet weak var burstCountADSLabel: UILabel!
    @IBOutlet weak var firstBulletAccADSLabel: UILabel!
    @IBOutlet weak var skinsCollectionOutlet: UICollectionView!
    
    
    var connection = Connection()
    var weaponuuid: String?
    var loader = Loading()
    let spanishLanguage = "language=es-ES"
    var weapon: WeaponDow?
    var type = ""
    var fireMode = ""
    var penetration = ""
    var cost = 0
    var skins: [Skins] = []
    var chromas: [Chromas] = []
    var imageDonwlodaded = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statsWeaponView.layer.cornerRadius = 5
        statsWeaponView.layer.borderWidth = 3
        statsWeaponView.layer.borderColor = #colorLiteral(red: 0.9240000248, green: 0.3059999943, blue: 0.3289999962, alpha: 1)
        
        rangeDamageView.layer.borderWidth = 3
        rangeDamageView.layer.borderColor = #colorLiteral(red: 0.9089635611, green: 0.8954972625, blue: 0.876429975, alpha: 1)
        
        skinsCollectionOutlet.dataSource = self
        skinsCollectionOutlet.delegate = self
        
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
                
                for i in 0...(weapon.data?.skins.count)! - 1{
                    
                    skins.append((weapon.data?.skins[i])!)
                    
                    
                  
                        connection.getImage(urlString: skins[i].displayIcon ?? "") {[self] (image) in
                            if let image = image {
                                skins[i].image = image
                                imageDonwlodaded += 1
                                print(imageDonwlodaded)
                            }
                            DispatchQueue.main.async {
                                skinsCollectionOutlet.reloadData()
                                
                            }
                        }
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
                    FireRateLabel.text = "\(weapon.data?.weaponStats?.fireRate ?? 0) RDS/SEG"
                    multiSpeedLabel.text = "\(weapon.data?.weaponStats?.runSpeedMultiplier ?? 0) M/SEG"
                    reloadTimeLabel.text = "\(weapon.data?.weaponStats?.reloadTimeSeconds ?? 0) SEG"
                    magazineLabel.text = "\(weapon.data?.weaponStats?.magazineSize ?? 0) RDS"
                    firstBulletAccLabel.text = "\(weapon.data?.weaponStats?.firstBulletAccuracy ?? 0) DEG"
                    headDama01Label.text = String(format: "%.1f", weapon.data?.weaponStats?.damageRanges[0]!.headDamage ?? 0)
                    headDama02Label.text = String(format: "%.1f", weapon.data?.weaponStats?.damageRanges[1]!.headDamage ?? 0)
                    bodyDama01Label.text = String(format: "%.1f", weapon.data?.weaponStats?.damageRanges[0]!.bodyDamage ?? 0)
                    bodyDama02Label.text = String(format: "%.1f", weapon.data?.weaponStats?.damageRanges[1]!.bodyDamage ?? 0)
                    legDama01Label.text = String(format: "%.1f", weapon.data?.weaponStats?.damageRanges[0]!.legDamage ?? 0)
                    legDama02Label.text = String(format: "%.1f", weapon.data?.weaponStats?.damageRanges[1]!.legDamage ?? 0)
                    FireRateADSLabel.text = "\(weapon.data?.weaponStats?.adsStats?.fireRate ?? 0) RDS/SEG"
                    multiSpeedADSLabel.text = "\(weapon.data?.weaponStats?.adsStats?.runSpeedMultiplier ?? 0) M/SEG"
                    multiZoomADSLabel.text = "\(weapon.data?.weaponStats?.adsStats?.zoomMultiplier ?? 0)x"
                    burstCountADSLabel.text = "\(weapon.data?.weaponStats?.adsStats?.burstCount ?? 0) "
                    firstBulletAccADSLabel.text = "\(weapon.data?.weaponStats?.adsStats?.firstBulletAccuracy ?? 0) DEG"
                    

                    
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        skins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skinsCell", for: indexPath) as! SkinsCollectionViewCell
        
        
        cell.weaponName.text = skins[indexPath.row].displayName
        cell.WeaponImage.image = skins[indexPath.row].image
      
        return cell
        
    }
}
