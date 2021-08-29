

import UIKit

class MiscListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
   
    
    @IBOutlet weak var collectionOutlet: UICollectionView!
    @IBOutlet weak var segmentedOutlet: UISegmentedControl!
    
    var connection = Connection()
    let spanishLanguage = "language=es-ES"
    var cards: [Card] = []
    let MAX_IMAGE_DATA1 = 169
    let MAX_IMAGE_DATA2 = 183
    var imageDonwlodaded = 0
    var loading = Loading()
    var sprays: [Spray] = []
    var segm0 = true
    var segm1 = false
    var numSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionOutlet.dataSource = self
        collectionOutlet.delegate = self
        segmentedOutlet.selectedSegmentIndex = numSelected
        connectionGetListAndImage()
        
        if imageDonwlodaded < MAX_IMAGE_DATA1 {
            self.loading.setupLoadingViews(controller: self)
            self.loading.showLoading(controller: self)
        }
       
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if segm0 == true{
       return cards.count
        }
        
        return sprays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "miscCell", for: indexPath) as! MiscCollectionViewCell
        
        if segm0 == true{
        cell.miscImage.image = cards[indexPath.row].image
        }else{
            cell.miscImage.image = sprays[indexPath.row].image
        }
        return cell
        
    }
    
    func connectionGetListAndImage() {
        
        connection.getCards(language: spanishLanguage) { [self] (cards) in
            if let cards = cards {
                self.cards = cards.data!
              
                
                self.cards = self.cards.sorted { $0.displayName! < $1.displayName! }
                for card in self.cards {
                    connection.getImage(urlString: card.displayIcon!) {[self] (image) in
                        if let image = image {
                            card.image = image
                            imageDonwlodaded += 1
                            print(imageDonwlodaded)
                        }
                        if imageDonwlodaded >= MAX_IMAGE_DATA1 {
                            DispatchQueue.main.async {
                                self.loading.hideLoading()
                                collectionOutlet.reloadData()
                                
                            }
                        }
                    }
                }
            }
        }
        connection.getSprays(language: spanishLanguage) { [self] (sprays) in
            if let sprays = sprays {
                self.sprays = sprays.data!
              
                
                self.sprays = self.sprays.sorted { $0.displayName! < $1.displayName! }
                for spray in self.sprays {
                    connection.getImage(urlString: spray.displayIcon!) {[self] (image) in
                        if let image = image {
                            spray.image = image
                            imageDonwlodaded += 1
                            print(imageDonwlodaded)
                        }
                        if imageDonwlodaded >= MAX_IMAGE_DATA2 {
                            DispatchQueue.main.async {
                                self.loading.hideLoading()
                                collectionOutlet.reloadData()
                                
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPaths = self.collectionOutlet.indexPathsForSelectedItems
        let indexPath = indexPaths![0] as NSIndexPath
        
        if let detailVLC = segue.destination as? CardDetailViewController {
            
            if segm0 == true{
                detailVLC.cardView = true
                detailVLC.cardUurl = cards[indexPath.row].uuid
            }else{
                detailVLC.cardView = false
                detailVLC.cardUurl = sprays[indexPath.row].uuid
            }
           
        }
    }
    
    @IBAction func segmentedAction(_ sender: Any) {
        
        if segmentedOutlet.selectedSegmentIndex == 0{
            
            numSelected = 0
            segm0 = true
            segm1 = false
            collectionOutlet.reloadData()
            
        }
        
        if segmentedOutlet.selectedSegmentIndex == 1{
            
            numSelected = 1
            segm1 = true
            segm0 = false
            collectionOutlet.reloadData()
            
        }
    }
    
  

}
