

import UIKit

class MiscListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
   
    
    @IBOutlet weak var collectionOutlet: UICollectionView!
    
    var connection = Connection()
    let spanishLanguage = "language=es-ES"
    var cards: [Card] = []
    let MAX_IMAGE_DATA = 169
    var imageDonwlodaded = 0
    var loading = Loading()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionOutlet.dataSource = self
        collectionOutlet.delegate = self

        connectionGetListAndImage()
       
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "miscCell", for: indexPath) as! MiscCollectionViewCell
        
     
        cell.miscImage.image = cards[indexPath.row].image
        
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
                        if imageDonwlodaded >= MAX_IMAGE_DATA {
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
            detailVLC.cardUurl = cards[indexPath.row].uuid
            
           
        }
    }
  

}
