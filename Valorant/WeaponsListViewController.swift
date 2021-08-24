

import UIKit

class WeaponsListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
   
    
    var connection = Connection()
    let spanishLanguage = "language=es-ES"
    var weapons: [Weapon] = []
    let MAX_IMAGE_DATA = 17
    var imageDonwlodaded = 0
    var loading = Loading()
    var weapons2: [Weapon] = []
    var num = 0
    
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
        return weapons2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header01", for: indexPath) as? HeaderWeaponsListCollectionReusableView{
            sectionHeader.headerTitle01.text = "Rifles"
            return sectionHeader
        }
        return UICollectionReusableView()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weaponsCell", for: indexPath) as! WeaponsListCollectionViewCell
        
        cell.weaponImage.image = weapons2[indexPath.row].image
        cell.weaponName.text = weapons2[indexPath.row].displayName
        cell.layer.borderWidth = 5
        cell.layer.borderColor = #colorLiteral(red: 0.1379934549, green: 0.1608571708, blue: 0.1884222329, alpha: 1)
        
        
        return cell
    }
    
    
    func connectionGetListAndImage() {
        
        connection.getWeapons(language: spanishLanguage) { [self] (weapons) in
            if let weapons = weapons {
                
                for i in 0...weapons.data!.count - 1{
                    if weapons.data![i].category == "EEquippableCategory::Rifle"{
                        num = i
                        
                        for i in self.num...self.num{
                            weapons2.append(weapons.data![i])
                        }
                        
                    }
                }
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
