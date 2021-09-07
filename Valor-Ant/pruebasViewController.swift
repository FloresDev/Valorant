//
//  pruebasViewController.swift
//  Valorant
//
//  Created by daniel on 07/04/2021.
//

import UIKit

class pruebasViewController: UIViewController {

    @IBOutlet weak var pruebaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(funcLabel(_:)))
        pruebaLabel.isUserInteractionEnabled = true
        pruebaLabel.addGestureRecognizer(tap)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func purebaButton(_ sender: Any) {
        print("Clickado")
    }
    
    @objc func funcLabel(_ sender: UITapGestureRecognizer) {
        print("Label clickado")
    }
    
}
