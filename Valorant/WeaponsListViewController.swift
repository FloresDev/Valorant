

import UIKit

class WeaponsListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var connection = Connection()
    let spanishLanguage = "language=es-ES"
    var weapons: [Weapon] = []
    let MAX_IMAGE_DATA = 17
    var imageDonwlodaded = 0
    var loading = Loading()
    var segm0 = true
    var segm1 = false
    var segm2 = false
    var segm3 = false
    var segm4 = false
    var segm5 = false
    var numSelected = 0
    var weaponsNameArr: [String?] = []
    var weaponsImaArr: [UIImage?] = []
    var weaponsnum = 0
    var refreshControl = UIRefreshControl()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        WeaponsNewArr()
        
        if imageDonwlodaded < MAX_IMAGE_DATA {
            self.loading.setupLoadingViews(controller: self)
            self.loading.showLoading(controller: self)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //cuando va a aparecer la vista, los segmentos estar deshabilitados por defecto
        connectionGetListAndImage()
        
        segmentOutlet.selectedSegmentIndex = numSelected
        
        viewDidLoad()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return weaponsNameArr.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weaponsCell", for: indexPath) as! WeaponsListCollectionViewCell
        
        if segm0 == true || segm1 == true || segm2 == true || segm3 == true || segm4 == true || segm5 == true{
            
            cell.weaponImage.image = weaponsImaArr[indexPath.row]
            cell.weaponName.text = weaponsNameArr[indexPath.row]
            cell.layer.cornerRadius = 10
        }
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
                                viewDidLoad()
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func segmentAct(_ sender: Any) {
        
        if segmentOutlet.selectedSegmentIndex == 0{
            
            numSelected = 0
            segm0 = true
            segm1 = false
            segm2 = false
            segm3 = false
            segm4 = false
            segm5 = false
            weaponsNameArr.removeAll()
            weaponsImaArr.removeAll()
            viewDidLoad()
            
        }
        
        if segmentOutlet.selectedSegmentIndex == 1{
            
            numSelected = 1
            segm1 = true
            segm0 = false
            segm2 = false
            segm3 = false
            segm4 = false
            segm5 = false
            weaponsNameArr.removeAll()
            weaponsImaArr.removeAll()
            viewDidLoad()
            
        }
        
        if segmentOutlet.selectedSegmentIndex == 2{
            
            numSelected = 2
            segm2 = true
            segm1 = false
            segm0 = false
            segm3 = false
            segm4 = false
            segm5 = false
            weaponsNameArr.removeAll()
            weaponsImaArr.removeAll()
            viewDidLoad()
            
        }
        
        if segmentOutlet.selectedSegmentIndex == 3{
            
            numSelected = 3
            segm3 = true
            segm2 = false
            segm1 = false
            segm0 = false
            segm4 = false
            segm5 = false
            weaponsNameArr.removeAll()
            weaponsImaArr.removeAll()
            viewDidLoad()
            
        }
        
        if segmentOutlet.selectedSegmentIndex == 4{
            
            numSelected = 4
            segm3 = false
            segm2 = false
            segm1 = false
            segm0 = false
            segm4 = true
            segm5 = false
            weaponsNameArr.removeAll()
            weaponsImaArr.removeAll()
            viewDidLoad()
            
        }
        
        if segmentOutlet.selectedSegmentIndex == 5{
            
            numSelected = 5
            segm3 = false
            segm2 = false
            segm1 = false
            segm0 = false
            segm4 = false
            segm5 = true
            weaponsNameArr.removeAll()
            weaponsImaArr.removeAll()
            viewDidLoad()
            
        }
    }
    
    func WeaponsNewArr(){
        
        if weapons.count - 1 > 0{
            
            for i in 0...weapons.count - 1{
                
                if weapons[i].category == "EEquippableCategory::Sidearm", segm0 == true{
                    self.weaponsnum = i
                    for i in self.weaponsnum...self.weaponsnum{
                        self.weaponsNameArr.append(weapons[i].displayName)
                        self.weaponsImaArr.append(weapons[i].image)
                        collectionView.reloadData()
                    }
                }
                
                if weapons[i].category == "EEquippableCategory::Rifle", segm1 == true{
                    self.weaponsnum = i
                    for i in self.weaponsnum...self.weaponsnum{
                        self.weaponsNameArr.append(weapons[i].displayName)
                        self.weaponsImaArr.append(weapons[i].image)
                        collectionView.reloadData()
                    }
                }
                
                if weapons[i].category == "EEquippableCategory::SMG", segm2 == true{
                    self.weaponsnum = i
                    for i in self.weaponsnum...self.weaponsnum{
                        self.weaponsNameArr.append(weapons[i].displayName)
                        self.weaponsImaArr.append(weapons[i].image)
                        collectionView.reloadData()
                    }
                }
                
                if weapons[i].category == "EEquippableCategory::Sniper", segm3 == true{
                    self.weaponsnum = i
                    for i in self.weaponsnum...self.weaponsnum{
                        self.weaponsNameArr.append(weapons[i].displayName)
                        self.weaponsImaArr.append(weapons[i].image)
                        collectionView.reloadData()
                    }
                }
                
                if weapons[i].category == "EEquippableCategory::Heavy", segm4 == true{
                    self.weaponsnum = i
                    for i in self.weaponsnum...self.weaponsnum{
                        self.weaponsNameArr.append(weapons[i].displayName)
                        self.weaponsImaArr.append(weapons[i].image)
                        collectionView.reloadData()
                    }
                }
                
                if weapons[i].category == "EEquippableCategory::Melee", segm5 == true{
                    self.weaponsnum = i
                    for i in self.weaponsnum...self.weaponsnum{
                        self.weaponsNameArr.append(weapons[i].displayName)
                        self.weaponsImaArr.append(weapons[i].image)
                        collectionView.reloadData()
                    }
                }
            }
        }
    }
}
