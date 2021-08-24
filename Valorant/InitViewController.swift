//
//  ViewController.swift
//  Valorant
//
//  Created by daniel on 05/04/2021.
//

import UIKit

class InitViewController: UIViewController {
    
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var buttons: UIStackView!
    
    @IBOutlet var initButtons: [UIButton]!
    var animationExecuting: Bool = false
    var loading = Loading()
    var timer = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.bg.loadGif(name: "presentation")
        setButtons()
        
    }
    
    func setButtons() {
        
        for initButton in initButtons {
            initButton.backgroundColor = #colorLiteral(red: 0.1806403697, green: 0.1843899488, blue: 0.2237628102, alpha: 1)
            
            initButton.layer.cornerRadius = 3.0;
            
            initButton.layer.borderWidth = 2.0;
            initButton.layer.borderColor = UIColor.clear.cgColor
            
            initButton.layer.shadowColor =  UIColor(displayP3Red: (100.0/255.0), green: 0.0, blue: 0.0, alpha: 1).cgColor
            initButton.layer.shadowOpacity = 1.0
            initButton.layer.shadowRadius = 1.0
            initButton.layer.shadowOffset = CGSize(width: 2, height: 5)
            
        }
    }
    
    @IBAction func animateButton(_ sender: UIButton) {
        self.animationExecuting = true
        self.loading.hideLoading()
        UIView.animate(withDuration: 0.2,
                       animations: {
                        sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.05) {
                            sender.transform = CGAffineTransform.identity
                            if sender.transform.isIdentity {
                                if sender.currentTitle == "Ver personajes" {
                                    self.performSegue(withIdentifier: "goToPersonTable", sender: self)
                                }
                                
                                
                            }
                            
                        }
                        
                        
                       })
        self.animationExecuting = false
        if sender.currentTitle == "Ver personajes" {
            
        }
        
    }
    
    //    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    //        // Si el identificador se corresponde y la tabla se está editando
    //        print("Entro")
    //        return true
    //    }
    //
}

