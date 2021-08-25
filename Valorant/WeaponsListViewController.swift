

import UIKit

class WeaponsListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var connection = Connection()
    let spanishLanguage = "language=es-ES"
    var weapons: [Weapon] = []
    let MAX_IMAGE_DATA = 17
    var imageDonwlodaded = 0
    var loading = Loading()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        connectionGetListAndImage()
        if imageDonwlodaded < MAX_IMAGE_DATA {
            self.loading.setupLoadingViews(controller: self)
            self.loading.showLoading(controller: self)
        
        }
      

        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return weapons.count
            
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weaponsCell", for: indexPath) as! WeaponsListCollectionViewCell
        
        cell.weaponImage.image = weapons[indexPath.row].image
        cell.weaponName.text = weapons[indexPath.row].displayName
        cell.layer.cornerRadius = 10
 
        return cell

        }

    func connectionGetListAndImage() {
        
        connection.getWeapons(language: spanishLanguage) { [self] (weapons) in
            if let weapons = weapons {
                
                self.weapons = weapons.data!
                
                self.weapons = self.weapons.sorted { $0.displayName! < $1.displayName! }
                for weapon in self.weapons {
                    connection.getImage(urlString: weapon.displayIcon!) {[self] (image) in
                        if let image = image {
                            weapon.image = image
                            imageDonwlodaded += 1
                            print(imageDonwlodaded)
                        }
                        if imageDonwlodaded >= MAX_IMAGE_DATA {
                            DispatchQueue.main.async {
                                self.loading.hideLoading()
                                collectionView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
}
