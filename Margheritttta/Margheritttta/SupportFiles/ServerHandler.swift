//
//  SeverHandler.swift
//  Margheritttta
//
//  Created by Lucas Assis Rodrigues on 21/05/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit
import KituraKit

final class ServerHandler {
    public static let shared = ServerHandler()

    private let url = "https://capricciosa.herokuapp.com"
    private let kitura: KituraKit?
    
    private init() {
        self.kitura = KituraKit(baseURL: url)
    }
    
    public func getAllProducts(completion: @escaping (([Product]?, Error?) -> Void)) {
        guard let kitura = kitura else {
            completion(nil, RequestError.internalServerError)
            return
        }
        
        kitura.get("/products/all") { (products:[Product]? , error: Error?) in
            guard let error = error  else {
                completion(products, nil)
                return
            }
            
            completion(nil, error)
        }
    }
}
