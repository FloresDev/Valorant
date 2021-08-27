//
//  MapsViewController.swift
//  Valorant
//
//  Created by daniel on 25/08/2021.
//

import UIKit

class MapsViewController: UIViewController, UIScrollViewDelegate {
    

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scroll: UIScrollView!
    
    var connection = Connection()
    var maps: [Map] = []
    var loader = Loading()
    var splashImageDownload = 0
    var iconImageDownload = 0
    var slides: [Slide] = []
    var slidesNumber = 0
    var mapNameSelected: String?
    
    
    override func viewWillAppear(_ animated: Bool) {
        // Para evitar tener scroll indeseado, deshabilitamos el scroll vertical con la siguiente línea de código
        scroll.contentSize.height = 1.0 // El contentSize del scroll igualadao a 1 hace que se deshabilite el scroll vertical
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroll.delegate = self
        
       
        
        
        connectionForMaps()
        self.loader.setupLoadingViews(controller: self)
        self.loader.showLoading(controller: self)
    }
    
    func connectionForMaps() {
        connection.getMaps { [self] (maps) in
            if let maps = maps {
                self.maps = maps.data!
                self.maps.remove(at: 5)
                for map in self.maps {
                    connection.getImage(urlString: map.splash!) {[self] (image) in
                        if let image = image {
                            map.artImage = image
                            splashImageDownload += 1
                        }
                        connection.getImage(urlString: map.displayIcon ?? "") { [self] (image) in
                            if let image = image {
                                map.mapIcon = image
                                iconImageDownload += 1
                                print("Descargas de iconos realizadas \(iconImageDownload)")
                            }
                            DispatchQueue.main.async {
                                if splashImageDownload >= 6, iconImageDownload >= 5 {
                                    self.loader.hideLoading()
                                    slides = createSlides()
                                    setupSlideScrollView(slides: slides)
                                    addTapFunction(slides: slides)
                                    pageControl.numberOfPages = slides.count
                                    pageControl.currentPage = 0
                                    view.bringSubviewToFront(pageControl)
                            }
                        }
                    }
                }
            }
        }
    }
}
    
    func shadowImage(imagen: UIImageView){
        imagen.layer.shadowRadius = 1
        imagen.layer.shadowOffset = .init(width: 10, height: 10)
        imagen.layer.shadowOpacity = 1
        imagen.layer.shadowColor = UIColor.black.cgColor
        imagen.layer.masksToBounds = false
    }
    

    func setupSlideScrollView(slides : [Slide]) {
        scroll.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scroll.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scroll.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scroll.addSubview(slides[i])
        }
    }
    
    // Creación de los slides que van a ir dentro del PageControl
    func createSlides() -> [Slide] {
        
        // CÓDIGO SIMPLIFICADO A PARTIR DEL TUTORIAL
        /**
         Creamos así un código escalable y modular, si posteriormente se agregan nuevos mapas, no deberemos modificar este código.
         Si lo dejamos como en la publicación original deberíamos modificar el código cada vez que se agregase un mapa nuevo a la API
         ¡OJO! para futuras debemos revisar si podemos hace lo mismo con el método que realiza las animaciones de los elementos al hacer
         scroll "scrollViewDidScroll", deberemos crear una variable numérica que se actualice de forma automática al detectar un nuevo mapa agregado
         y también acceder de otra forma al array de slides para no tener que añadir un caso por cada mapa nuevo
         */
        
        var createdSlides: [Slide] = []
        for i in 0 ... maps.count - 1{
            print("Me ejecuto")
            let slide:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide.mapBakcground.image = maps[i].artImage
            slide.mapName.text = maps[i].displayName
            slide.mapIconImage.image = maps[i].mapIcon
            shadowImage(imagen: slide.mapIconImage)
            createdSlides.append(slide)
            
        }
        // CODIGO ORIGINAL DEL TUTORIAL DEL SCROLL HORIZONTAL
        
//            let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//            slide1.mapBakcground.image = maps[0].artImage
//            slide1.mapName.text = maps[0].displayName
//            slide1.mapIconImage.image = maps[0].mapIcon
//            shadowImage(imagen: slide1.mapIconImage)
//
//            let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//            slide2.mapBakcground.image = maps[1].artImage
//            slide2.mapName.text = maps[1].displayName
//            slide2.mapIconImage.image = maps[1].mapIcon
//            shadowImage(imagen: slide2.mapIconImage)
//
//            let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//            slide3.mapBakcground.image = maps[2].artImage
//            slide3.mapName.text = maps[2].displayName
//            slide3.mapIconImage.image = maps[2].mapIcon
//            shadowImage(imagen: slide3.mapIconImage)
//
//            let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//            slide4.mapBakcground.image = maps[3].artImage
//            slide4.mapName.text = maps[3].displayName
//            slide4.mapIconImage.image = maps[3].mapIcon
//            shadowImage(imagen: slide4.mapIconImage)
//
//            let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//            slide5.mapBakcground.image = maps[4].artImage
//            slide5.mapName.text = maps[4].displayName
//            slide5.mapIconImage.image = maps[4].mapIcon
//            shadowImage(imagen: slide5.mapIconImage)
//
//            let slide6:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
//            slide6.mapBakcground.image = maps[5].artImage
//            slide6.mapName.text = maps[5].displayName
//            slide6.mapIconImage.image = maps[5].mapIcon
//            shadowImage(imagen: slide6.mapIconImage)
        
            
        return createdSlides
        }
    
    // Función que se ejecuta al hacer Scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        print("El percent offset es \(percentOffset.x)")
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.2) {
                    
            slides[0].mapIconImage.transform = CGAffineTransform(scaleX: (0.2-percentOffset.x)/0.2, y: (0.2-percentOffset.x)/0.2)
            slides[0].mapName.transform = CGAffineTransform(scaleX: (0.2-percentOffset.x)/0.2, y: (0.2-percentOffset.x)/0.2)
            slides[1].mapIconImage.transform = CGAffineTransform(scaleX: percentOffset.x/0.2, y: percentOffset.x/0.2)
                    slides[1].mapName.transform = CGAffineTransform(scaleX: percentOffset.x/0.2, y: percentOffset.x/0.2)
        }
        else if(percentOffset.x > 0.2 && percentOffset.x <= 0.4) {
                    slides[1].mapIconImage.transform = CGAffineTransform(scaleX: (0.4-percentOffset.x)/0.2, y: (0.4-percentOffset.x)/0.2)
                    slides[1].mapName.transform = CGAffineTransform(scaleX: (0.4-percentOffset.x)/0.2, y: (0.4-percentOffset.x)/0.2)
                    slides[2].mapIconImage.transform = CGAffineTransform(scaleX: percentOffset.x/0.4, y: percentOffset.x/0.4)
                    slides[2].mapName.transform = CGAffineTransform(scaleX: percentOffset.x/0.4, y: percentOffset.x/0.4)
                    
        }
        else if(percentOffset.x > 0.4 && percentOffset.x <= 0.6) {
                    slides[2].mapIconImage.transform = CGAffineTransform(scaleX: (0.6-percentOffset.x)/0.2, y: (0.6-percentOffset.x)/0.2)
                    slides[2].mapName.transform = CGAffineTransform(scaleX: (0.6-percentOffset.x)/0.2, y: (0.6-percentOffset.x)/0.2)
                    slides[3].mapIconImage.transform = CGAffineTransform(scaleX: percentOffset.x/0.6, y: percentOffset.x/0.6)
                    slides[3].mapName.transform = CGAffineTransform(scaleX: percentOffset.x/0.6, y: percentOffset.x/0.6)
                    
        }
        else if(percentOffset.x > 0.6 && percentOffset.x <= 0.8) {
                    slides[3].mapIconImage.transform = CGAffineTransform(scaleX: (0.8-percentOffset.x)/0.2, y: (0.8-percentOffset.x)/0.2)
                    slides[3].mapName.transform = CGAffineTransform(scaleX: (0.8-percentOffset.x)/0.2, y: (0.8-percentOffset.x)/0.2)
                    slides[4].mapIconImage.transform = CGAffineTransform(scaleX: percentOffset.x/0.8, y: percentOffset.x/0.8)
                    slides[4].mapName.transform = CGAffineTransform(scaleX: percentOffset.x/0.8, y: percentOffset.x/0.8)
                    
        }
        else if(percentOffset.x > 0.8 && percentOffset.x <= 1) {
                    slides[4].mapIconImage.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.2, y: (1-percentOffset.x)/0.2)
                    slides[4].mapName.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.2, y: (1-percentOffset.x)/0.2)
                    slides[5].mapIconImage.transform = CGAffineTransform(scaleX: percentOffset.x/1, y: percentOffset.x/1)
                    slides[5].mapName.transform = CGAffineTransform(scaleX: percentOffset.x/1, y: percentOffset.x/1)
                    
        }
    }
    
    // Se recive el array de slides y se recorre creando un gesto paraq cada uno de ellos y añadiéndolo
    func addTapFunction(slides: [Slide]){
        for slide in slides {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedMe))
            slide.mapIconImage.addGestureRecognizer(tap)
            slide.isUserInteractionEnabled = true
        }
    }
    // Función que se ejectuta al realizar el gesto agregado en la función "addTapFunction"
    @objc func tappedMe()
    {
        // Almacenamos en la variable el nombre del mapa, mediante la página actual del PageControl
        mapNameSelected = slides[pageControl.currentPage].mapName.text ?? "No hay nombre"
        self.performSegue(withIdentifier: "goToMapDetail", sender: self)
    }
    
    // Método que es llamado al cambiar la orientación del dispositivo
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // Deshabilitamos el scroll vertical
        scroll.contentSize.height = 1.0
    }
    
    // En viamos los datos al detalle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailMap = segue.destination as? DetailMapViewController {
            detailMap.mapName = mapNameSelected
            
        }
    }
    
    
}
