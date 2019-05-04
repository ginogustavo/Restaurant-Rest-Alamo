//
//  ViewController.swift
//  Restaurante
//
//  Created by Academia Moviles air8 on 5/4/19.
//  Copyright © 2019 com.academiamoviles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        CategoriaService().getAll()
        //RestAPI().callService(url: "https://diplomado-restaurant-backend.herokuapp.com/categorias", verb: "GET")
    }


}

