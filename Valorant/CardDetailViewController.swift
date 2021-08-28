

import UIKit

class CardDetailViewController: UIViewController {
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    
    var cardUurl: String?
    var connection = Connection()
    var loader = Loading()
    let spanishLanguage = "language=es-ES"
   
    var card = ""


    override func viewDidLoad() {
        super.viewDidLoad()
       
        
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

    }

}
