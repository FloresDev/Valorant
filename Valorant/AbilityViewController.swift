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

class AbilityViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var iconImageView: UIImageView!
    

    
    @IBOutlet weak var abilityNameLabel: UILabel!
    @IBOutlet weak var abilitySlotLabel: UILabel!
    @IBOutlet weak var abilityDescriptionLabel: UILabel!
    @IBOutlet weak var video: UIView!
    @IBOutlet weak var scrollHeight: NSLayoutConstraint!
    @IBOutlet weak var videoHeight: NSLayoutConstraint!
    @IBOutlet weak var scroll: UIScrollView!
    
    var ability: Ability?
    var imagePerson: UIImage?
    var urlImagePerson: String?
    var connection = Connection()
    // Reproductor para el vídeo (Proporcionado iOS)
    var player : AVPlayer!
    var abilityName: String = ""
    var url: URL?
    var screenSize = UIScreen.main.bounds
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scroll.delegate = self
        abilityName = (ability?.displayName)!.folding(options: .diacriticInsensitive, locale: .current)
        abilityNameLabel.text = abilityName
        abilitySlotLabel.text = ability?.slot
        abilityDescriptionLabel.text = ability?.description
        checkForScroll()
        
       
        

        
        connection.getImage(urlString: ability!.displayIcon!) { (image) in
            if let image = image {
                DispatchQueue.main.async { [self] in
                    iconImageView.image = image
                }
            }
        }
        initPlayer()
  
       
    }
    
    func checkForScroll(){
        let screenHeight = screenSize.height
        let wordCounter = ability?.description?.count
        var suma = abilityNameLabel.frame.height + video.frame.height + abilitySlotLabel.frame.height + abilityDescriptionLabel.frame.height + video.frame.height
        //suma = suma * 10
        print("La altura de la pantalla es de \(screenHeight) y la altura total de los elementos es de \(suma) y el contador es de: \(wordCounter!)")
        
        
        if screenHeight >= 896 {
            scrollHeight.constant = screenHeight
            if wordCounter! > 380, screenHeight < 1080 {
                scrollHeight.constant = screenHeight + CGFloat(wordCounter!) - 350
                print("Opcion 1 entro")
            }
        }else if screenHeight < 896, wordCounter! > 200 {
            print("Opcion 2 entro")
            scrollHeight.constant = screenHeight + CGFloat(wordCounter!) - 190
            print("El offset se ha modificado a \(scroll.contentOffset.y)")
            
            }
        else {
            print("Opcion 3 entro")
            scrollHeight.constant = screenHeight
            print("La posicion del scroll es de: \(scroll.contentOffset.y)")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //self.scroll.contentOffset = CGPoint(x:0, y: 400)
        print("La posicion del scroll es de: \(scroll.contentOffset.y)")
    }
        
    
    

    
    // Función para inicializar el player
    func initPlayer() {
        
        // Con esta condición obtengo los nombres de los archivos albergados en el Bundle de la app
        if let files = try? FileManager.default.contentsOfDirectory(atPath: Bundle.main.bundlePath ){
            // Recorro los archivos del Bundle
            for file in files {
                // A los que contengan la extensión .mp4 (Hago esto porque los guarda todos, ya sean vídeos o imágenes)
                if file.contains(".mp4"){
                    // Creo un string quitándole los 4 últimos caracteres, que son el ".mp4"
                    let stringModified1 = file.dropLast(4)
                    // Ahora a partir de ese primer string modificado obtengo los 4 últimos caracteres del nombre del archivo
                    // que por lo que he visto de momento coinciden con el nombre de la habilidad que nos viene en el segue
                    let stringModified2 = stringModified1.suffix(4)
                    print("El archivo modificado es \(stringModified2)")
                    print("El habilityName es: \(abilityName)")
                    // Comprobamos la coincidencia llevándolo todo a minúsculas para evitar errores
                    if abilityName.lowercased().contains(stringModified2.lowercased()){
                        print("Coincide")
                        print("La coincidencia es de \(stringModified2) y \(abilityName)")
                        if abilityName == "ENGANO" {
                            abilityNameLabel.text = "Engaño"
                        }
                        // Creamos la url a partir del string que modificamos en primera instancia ya que es el que no tiene el ".mp4"
                        url = Bundle.main.url(forResource: "\(stringModified1)", withExtension: "mp4")
                    }
                }
            }
        }
        
        // Seleccionamos la opción del constructor que recibe la url
        if let url = url {
            player = AVPlayer(url: url)
        }
        else {
            return
        }
       
        
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
        
        // *** Línea añadida para que la capa del vídeo se adapte al marco completamente ***/
        layer.videoGravity = .resizeAspectFill
        
        
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
