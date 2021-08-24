//
//  DetailViewController.swift
//  Valorant
//
//  Created by daniel on 06/04/2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate, UITableViewDelegate {
    
    
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var roleImageView: UIImageView!
    @IBOutlet weak var roleNameLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var video: WKWebView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var connection = Connection()
    var agent: Person?
    var loader = Loading()
    // Variable que hace uso de la clase de Scroll personalizada
    //var scroll = ScrollViewController()
    var abilities: [Ability] = []
    var index = 0
    var url:URL?
    var cellIsSelected: Bool = false
    
    let sageUrl = "https://www.youtube.com/embed/tKTqzd0Xzl0?playsinline=1"
    let astraUrl = "https://www.youtube.com/embed/-ylVnuPWlJM?start=5&?playsinline=1"
    let breachUrl = "https://www.youtube.com/embed/Rux0HjzKQbw?playsinline=1"
    let brimStoneUrl = "https://www.youtube.com/embed/7yHnJ_oNxTI?playsinline=1"
    let cypherUrl = "https://www.youtube.com/embed/SgbqFtRRgLA?playsinline=1"
    let killJoyUrl = "https://www.youtube.com/embed/ua-iIRQDY8g?playsinline=1"
    let jetUrl = "https://www.youtube.com/embed/eExLTGyOFN4?playsinline=1"
    let omenUrl = "https://www.youtube.com/embed/_jJdWy6bDj4?playsinline=1"
    let phoenixUrl = "https://www.youtube.com/embed/ttJMFW2wUQM?playsinline=1"
    let razeUrl = "https://www.youtube.com/embed/2-uAL__pp_U?playsinline=1"
    let reynaUrl = "https://www.youtube.com/embed/IzsQNYrq9AM?playsinline=1"
    let skyeUrl = "https://www.youtube.com/embed/C3QTyMXi-WE?playsinline=1"
    let sovaUrl = "https://www.youtube.com/embed/OZ76UP-c8Ao?playsinline=1"
    let viperUrl = "https://www.youtube.com/embed/9dOSy0EhLfQ?playsinline=1"
    let yoruUrl = "https://www.youtube.com/embed/GdOEQv-zQVw?start=2&playsinline=1"
    let kayO = "https://www.youtube.com/embed/AUfDJAn3Upw?start=2&playsinline=1"
    
    
    override func viewWillAppear(_ animated: Bool) {
        // Recargamos la tabla cuando vaya a aparecer para evitar tener marcada la selección anterior al volver
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Llamadas para setear el loader usando este controlador para ello
        loader.setupLoadingViews(controller: self)
        loader.showLoading(controller: self)
        descriptionLabel.isHidden = true
        
        // Configuración de vídeo del personaje
        video.configuration.allowsInlineMediaPlayback = true
        setUrl()
        abilities = abilities.sorted { $0.displayName! < $1.displayName! }
        
       
        
      
        // La variable de scroll se usaba aquí pero se usó para pruebas
        
        //scrollView.touchesShouldCancel(in: pruebaActionLabel)
        //scrollView.canCancelContentTouches = false
        //scrollView.panGestureRecognizer.delaysTouchesBegan = true
        //scrollView.delaysContentTouches = false
        //scrollView.isExclusiveTouch = false
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(funcionTap(_:)))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(funcionTap(_:)))
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(funcionTap(_:)))
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(funcionTap(_:)))
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(funcionTap(_:)))

        var gestures = [UITapGestureRecognizer]()
        gestures.append(tap)
        gestures.append(tap2)
        gestures.append(tap3)
        gestures.append(tap4)
        gestures.append(tap5)
        
        if let person = agent {
            title = "\(person.displayName!)"
            abilities = person.abilities!
            connection.getImage(urlString: person.bustPortrait!) { [self] (image) in
                connection.getImage(urlString: (person.role?.displayIcon)!) { (image) in
                    DispatchQueue.main.async {
                        self.roleImageView.image = image
                        self.roleNameLabel.text = person.role?.displayName
                    }
                    
                }
                DispatchQueue.main.async {
                    detailImageView.image = image
                    nameLabel.text = person.displayName
                    descriptionLabel.text = person.description
                    descriptionLabel.isHidden = false
                    loader.hideLoading()
                }
            }
            
          
//                        for ability in abilities {
//                            
//                            let label = UILabel()
//                            label.isUserInteractionEnabled = true
//                            label.addGestureRecognizer(gestures[index])
//                            index += 1
//                            label.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
//                            label.textColor = .white
//                            label.font = .systemFont(ofSize: 20, weight: .semibold)
//                            label.textAlignment = .center
//                            label.text = ability.displayName!
//                            
//                            self.stackAbilities.addArrangedSubview(label)
//            
//                        }
        }
        
        print("Hemos llegado")
        
        
    }
    
    @objc func funcionTap(_ sender: UITapGestureRecognizer){
        print("Entro")
        performSegue(withIdentifier: "goToAbilityDetail", sender: self)
    }
    
    func setUrl(){
        
        switch agent?.displayName {
        case "Astra":
             url = URL(string: astraUrl)
            break
        case "Breach":
            url = URL(string: breachUrl)
            break
        case "Brimstone":
            url = URL(string: brimStoneUrl)
        case "Cypher":
            url = URL(string: cypherUrl)
            break
        case "Jett":
            url = URL(string: jetUrl)
            break
        case "KAY/O":
            url = URL(string: kayO)
            break
        case "Killjoy":
            print("Kill")
            url = URL(string: killJoyUrl)
            break
        case "Omen":
            url = URL(string: omenUrl)
            break
        case "Phoenix":
            url = URL(string: phoenixUrl)
            break
        case "Raze":
            url = URL(string: razeUrl)
            break
        case "Reyna":
            url = URL(string: reynaUrl)
            break
        case "Sage":
            url = URL(string: sageUrl)
            break
        case "Skye":
            url = URL(string: skyeUrl)
            break
        case "Sova":
            url = URL(string: sovaUrl)
            break
        case "Viper":
            url = URL(string: viperUrl)
            break
        case "Yoru":
            url = URL(string: yoruUrl)
        default:
            url = nil
        }
       
        let youtubeRequest = URLRequest(url: url!)
        video.load(youtubeRequest)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return abilities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = abilities[indexPath.row].displayName
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.backgroundColor = #colorLiteral(red: 0.1963853836, green: 0.1991316676, blue: 0.2378860116, alpha: 1)
        // Cambiamos el color de selección de la celda
        // Lo haremos siempre que la variable esté a false para evitar que al volver de la vista de detalle
        // Se quede la selección anterior marcada
        if !cellIsSelected {
            let backgroundView = UIView()
            backgroundView.backgroundColor = #colorLiteral(red: 0.9239210486, green: 0.3054641187, blue: 0.3290764093, alpha: 1)
            cell.selectedBackgroundView = backgroundView
        }
        cell.layer.borderColor = UIColor(named: "TextColor")?.cgColor
        cell.layer.borderWidth = 2.0
        return cell
    }
    
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow!.row
        if segue.identifier == "goToDetailAbility"{
            if let detailAbilityVLC = segue.destination as? AbilityViewController {
                detailAbilityVLC.ability = abilities[indexPath]
                detailAbilityVLC.urlImagePerson = agent?.fullPortrait
                // Al seleccionar una celda, seteamos la variable a true para evitar que exista
                // esta selección en la tabla al volver
                cellIsSelected = true
                print("Celda seleccionada, la variable está \(cellIsSelected)")
            }
        }
     }
     
}


