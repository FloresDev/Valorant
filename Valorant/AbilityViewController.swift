//
//  AbilityViewController.swift
//  Valorant
//
//  Created by daniel on 08/04/2021.
//

import UIKit

// Importamos AVFoundation para trabajar con el vídeo (audio y vídeo)
import AVFoundation

//Para vídeo importamos AVKit para que tengamos acceso a los controles de reproducción
import AVKit

class AbilityViewController: UIViewController {
    
    @IBOutlet weak var iconImageView: UIImageView!
    

    
    @IBOutlet weak var abilityNameLabel: UILabel!
    @IBOutlet weak var abilitySlotLabel: UILabel!
    @IBOutlet weak var abilityDescriptionLabel: UILabel!
    @IBOutlet weak var video: UIView!
    
    var ability: Ability?
    var imagePerson: UIImage?
    var urlImagePerson: String?
    var connection = Connection()
    // Reproductor para el vídeo (Proporcionado iOS)
    var player : AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        abilityNameLabel.text = ability?.displayName
        abilitySlotLabel.text = ability?.slot
        abilityDescriptionLabel.text = ability?.description

        
        connection.getImage(urlString: ability!.displayIcon!) { (image) in
            if let image = image {
                DispatchQueue.main.async { [self] in
                    iconImageView.image = image
                }
            }
        }
        initPlayer()
       
    }
    
    // Función para inicializar el player
    func initPlayer() {
        // Creamos la url a partir del Bundle ya que el archivo está dentro de la app
        let url = Bundle.main.url(forResource: "SovaFlechas", withExtension: "mp4")
        
        // Seleccionamos la opción del constructor que recibe la url
        player = AVPlayer(url: url!)
        
//        // Variable controller para la reproducción (Lo inicializamos vacío)
//        let controller = AVPlayerViewController()
//        // Al controlador hay que asociarle el reproductor
//        controller.player = player
//        // Presentamos el controlador para mostrarlo
//        present(controller, animated: true)
        
        // Variable layer para el vídeo (Personalizado)
        /*
         Utilizamos esta variable para meter el reproductor
         Esta variable es la capa que era antes controller en el proporcionado por iOS
         */
        let layer = AVPlayerLayer(player: player)
        // Adaptamos el marco del vídeo a nuestra vista (video)
        layer.frame = video.bounds
        
        // Añadimos el layer a la vista
        video.layer.addSublayer(layer)
        
        
        player.play()
        
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
