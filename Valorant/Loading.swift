//
//  ViewController.swift
//  testLoading
//
//  Created by daniel on 31/03/2021.
//

// Vista de cargando que podremos reutilizar en todas las pantallas

import UIKit

class Loading {
    
    // Variables para las vistas
    // ActivityIndicator
    var activityIndicator = UIActivityIndicatorView()
    // Variable para la vista que vamos a utilizar de contenedor
    var container = UIView()
    // La vista que va a tener la parte del cargando
    var loadingView = UIView()
    // Etiqueta que va atener el texto
    var loadingLabel = UILabel()


    
    func setupLoadingViews(controller: UIViewController) {
        
        // Container que va a contener a todo lo demás con el difuminado para que lo de atrás no se vea
        container.frame = CGRect(x: controller.view.frame.origin.x, y: controller.view.frame.origin.y, width: controller.view.frame.width, height: controller.view.frame.height)
        container.backgroundColor = #colorLiteral(red: 0.934802711, green: 0.3080254197, blue: 0.3367152214, alpha: 1)
        
        // LoadingView
        loadingView.frame = CGRect(x: 0, y: 0, width: 180, height: 180)
        loadingView.center.x = container.center.x
        loadingView.center.y = container.center.y 
        loadingView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.7)
        // Le decimos que establezca a true el clip to bounds para que no se salga de los márgenes
        loadingView.clipsToBounds = true
        // Queremos que los bordes sean redondeados
        loadingView.layer.cornerRadius = 10
        
        // ActivityIndicatorView
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        // Le decimos que el estilo sea el largo
        activityIndicator.style = .large
        // Que el centro sea el mismo que el de la vista
        activityIndicator.center = loadingView.center
        // Le decimos que tenga un color blanco
        activityIndicator.color = .white
        // Empezará estando animado
        activityIndicator.startAnimating()
        
        // Label
        loadingLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        // No queremos que el centro sea el de la vista ahora será el mismo centro pero desplazado hacia abajo
        let center = activityIndicator.center
        loadingLabel.center = CGPoint(x: center.x, y: center.y + 40)
        // La etiqueta tendrá el texto alineado al centro
        loadingLabel.textAlignment = .center
        // El texto que va a tener
        loadingLabel.text = "Loading..."
        // El color del texto
        loadingLabel.textColor = .white
        
    }
    
    // Función para mostrar la carga
    func showLoading(controller: UIViewController){
        // Añadimos las subVistas en ese orden
        controller.view.addSubview(container)
        controller.view.addSubview(loadingView)
        controller.view.addSubview(activityIndicator)
        controller.view.addSubview(loadingLabel)
    }
    
    // Función para esconder la carga
    func hideLoading(){
        // Eliminamos las vistas de la vista padre en el orden inverso al de añadir
        loadingLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        loadingView.removeFromSuperview()
        container.removeFromSuperview()
    }
}
