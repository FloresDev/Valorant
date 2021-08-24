//
//  ScrollViewController.swift
//  InterfazAvanzada
//
//  Created by daniel on 09/02/2021.
//

import UIKit

class ScrollViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cuando se carga la vista añadimos el scrollview
        view.addSubview(scrollView)
        // En el scrollview añadimos el scrollViewContainer que es el que tiene el StackView
        scrollView.addSubview(scrollViewContainer)
        // En el ScrollViewContainer añadimos las tres vistas
        scrollViewContainer.addArrangedSubview(redView)
        scrollViewContainer.addArrangedSubview(blueView)
        scrollViewContainer.addArrangedSubview(greenView)
        
        // Ponemos las constraints al ScrollViewv para que coja automáticamentes todos los anchos de la vista padre
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Al ScrollViewContainer le decimos también que coja los anchos del ScrollView
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        // Le ponemos el mismo ancho al ScrollView que el StackView (PARTE MÁS IMPORTANTE, NOS PERMITIRÁ HACER EL SCROLL)
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        // Contraint para Scroll horizontal
        //scrollViewContainer.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }
    // Función creada por mí para probar el añadir vistas al scroll
    func addScroll(controller: UIViewController, vista1: UIView, vista2: UIView, vista3: UIView, vista4: UIView, vista5: UIView ) {
        controller.view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        // En el ScrollViewContainer añadimos las tres vistas
        scrollViewContainer.addArrangedSubview(vista1)
        scrollViewContainer.addArrangedSubview(vista2)
        scrollViewContainer.addArrangedSubview(vista3)
        scrollViewContainer.addArrangedSubview(vista4)
        scrollViewContainer.addArrangedSubview(vista5)
        
        // Ponemos las constraints al ScrollViewv para que coja automáticamentes todos los anchos de la vista padre
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Al ScrollViewContainer le decimos también que coja los anchos del ScrollView
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        // Le ponemos el mismo ancho al ScrollView que el StackView (PARTE MÁS IMPORTANTE, NOS PERMITIRÁ HACER EL SCROLL)
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
  
    }
    
    
    // El StackView irá dentro del scrollView
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        // Línea que hace que las vistas sean más libres y no se ajusten al ancho del dispositivo
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // StackView donde irán metidas las vistas
    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        
        //Axis define la posición del stacckView (horizontal o vertical) .horizontal para Scroll horizontal
        view.axis = .vertical
        view.spacing = 10
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
//    // -- VISTAS QUE APARECERÁN EN LA PANTALLA --//
//
    // Vista roja
    let redView: UIView = {
        let view = UIView()
        // Vertical
        view.heightAnchor.constraint(equalToConstant: 500).isActive = true
        // Horizontal
        //view.widthAnchor.constraint(equalToConstant: 500).isActive = true
        view.backgroundColor = .red
        return view
    }()
    // Vista azul
    let blueView: UIView = {
        let view = UIView()
        // Vertical
        view.heightAnchor.constraint(equalToConstant: 500).isActive = true
        // Horizontal
        //view.widthAnchor.constraint(equalToConstant: 500).isActive = true
        view.backgroundColor = .blue
        return view
    }()
    // Vista verde
    let greenView: UIView = {
        let view = UIView()
        // Vertical
        view.heightAnchor.constraint(equalToConstant: 500).isActive = true
        // Horizontal
        //view.widthAnchor.constraint(equalToConstant: 500).isActive = true
        view.backgroundColor = .green
        return view
    }()
}
