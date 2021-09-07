//
//  DetailMapViewController.swift
//  Valorant
//
//  Created by daniel on 27/08/2021.
//

import UIKit

class DetailMapViewController: UIViewController {
    
    @IBOutlet weak var mapNameLabel: UILabel!
    @IBOutlet weak var imageMapDetail: UIImageView!
    var mapName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

         print("El nombre del mapa que nos traemos es: \(mapName ?? "")")
        imageMapDetail.image = UIImage(imageLiteralResourceName: "\(mapName!)_Map_Detail")
        mapNameLabel.text = "Zonas de \(mapName!)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
