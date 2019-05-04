//
//  RestAPI.swift
//  Restaurante
//
//  Created by Academia Moviles air8 on 5/4/19.
//  Copyright © 2019 com.academiamoviles. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
// protocol = interface
protocol RestAPI{
}

extension RestAPI{
    
    func alamoService(url:String,
                     verb:HTTPMethod,
                     body:[String:Any]? = nil,
                     headers:[String:String]? = nil){
        
        let request = Alamofire.request(url,
                                        method: verb,
                                        parameters: body,
                                        encoding: URLEncoding.default,    //JSONEncoding.default,
                                        headers: headers)
        
        request.validate().responseJSON { (response) in
        
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
            case .failure(let error):
                print(error)
            }
        }
        
        //request.cancel()
        
    }
    
    func callService(url:String,
                     verb:String,
                     body:[String:Any]? = nil,
                     headers:[String:Any]? = nil){
        
        //let config = URLSessionConfiguration.background(withIdentifier: "")
        
        let config = URLSessionConfiguration.default
        //use cases that down alow connect through data plans, only wifi of company
        config.allowsCellularAccess = false
        config.timeoutIntervalForRequest = 3600
        config.httpAdditionalHeaders = headers
        
        let url1 = URL(string: url)!
        var request = URLRequest(url: url1)  // var y no let, xq es una estructura
        request.httpMethod = verb
        if let params = body {
        
            //cacheable
            /*
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            }catch(let ex){}      */
            
            //nullable
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            
            
        }
        
        let session = URLSession(configuration: config)
        
        
        let task1 = session.dataTask(with: request) { (data, urlResponse, error) in
            //
            OperationQueue.main.addOperation {
                if let anError = error {
                    print("Eror de conexion: \(anError.localizedDescription)")
                }
                
                guard let myData = data,
                    let httpResponse = urlResponse as? HTTPURLResponse,
                    httpResponse.statusCode <= 299,
                    httpResponse.statusCode >= 200     else {
                            print("Error en la respuesta")
                        return
                    }
                
                do{
                    let obj = try JSONSerialization.jsonObject(with: myData, options: .allowFragments)
                    print(obj)
                }catch(let ex){
                    print(ex)
                }
            }
            
        }
        
        task1.resume()
        task1.cancel() //romber la conexion, no parar la trx
        //let task2 = session.downloadTask(with: "") // Descarga de archivos grandes
        //let task3 = session.uploadTask // Subir archivos grandes
    }
    
}
