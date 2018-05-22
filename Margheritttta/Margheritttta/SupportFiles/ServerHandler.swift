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
    private let kitura: KituraKit?

    public static let shared = ServerHandler()
     
    private init() {
        kitura = KituraKit(baseURL: "https://capricciosa.herokuapp.com")
    }
    
    public func getAllProducts(completion: @escaping (([Product]?, Error?) -> Void)) {
        guard let kitura = kitura else {
            completion(nil, RequestError.internalServerError)
            return
        }
        
        kitura.get("/products/all") { (products: [Product]?, error: Error?) in
            completion(products, error)
        }
    }
    
    public func getProductsBy(venueId: String, completion: @escaping (([Product]?, Error?) -> Void)) {
        guard let kitura = kitura else {
            completion(nil, RequestError.internalServerError)
            return
        }
        
        kitura.get("/products?venueId=\(venueId)") { (products: [Product]?, error: Error?) in
            completion(products, error)
        }
    }
}
