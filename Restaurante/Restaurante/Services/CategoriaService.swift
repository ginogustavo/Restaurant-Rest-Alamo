//
//  CategoriaService.swift
//  Restaurante
//
//  Created by Academia Moviles air8 on 5/4/19.
//  Copyright © 2019 com.academiamoviles. All rights reserved.
//

import Foundation

class CategoriaService: RestAPI{
    
    
    func getAll() {
        let url = "https://diplomado-restaurant-backend.herokuapp.com/categorias"
        
        //RestAPI().callService(url: "", verb: "GET")
       alamoService(url: url, verb: .get)
    }
    
}
