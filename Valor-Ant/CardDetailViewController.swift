

import UIKit

class CardDetailViewController: UIViewController {
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var sprayName: UILabel!
    @IBOutlet weak var sprayImage: UIImageView!
    
    var cardUurl: String?
    var connection = Connection()
    var loader = Loading()
    let spanishLanguage = "language=es-ES"
    var cardView = false
    var card = ""
    var spray = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        if cardView == true{
            connection.getCard(language: spanishLanguage, uuid: cardUurl! ) { card in
                
                if let card = card {
                    
                    self.connection.getImage(urlString: card.data?.largeArt ?? "") { image in
                        if let image = image {
                            card.data!.image = image
                            
                            DispatchQueue.main.async {
                                self.cardName.text = card.data?.displayName
                                self.cardImage.image = card.data?.image
                            }
                        }
                    }
                }
            }
        }else{
            cardName.isHidden = true
            cardImage.isHidden = true
            sprayName.isHidden = false
            sprayImage.isHidden = false
            connection.getSpray(language: spanishLanguage, uuid: cardUurl! ) { spray in
                
                if let spray = spray {
                    
                    self.connection.getImage(urlString: spray.data?.fullTransparentIcon ?? "") { image in
                        if let image = image {
                            spray.data!.image = image
                            
                            DispatchQueue.main.async {
                                self.sprayName.text = spray.data?.displayName
                                self.sprayImage.image = spray.data?.image
                            }
                        }
                    }
                }
            }
        }
    }
}
