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
}


//MARK: Products
extension ServerHandler {
    public func getAllProducts(completion: @escaping (([Product]?, Error?) -> Void)) {
        guard let kitura = kitura else {
            completion(nil, RequestError.internalServerError)
            return
        }
        
        kitura.get("/products/all") { (products:[Product]? , error: Error?) in
            completion(products, error)
        }
    }
    
    public func post(product: Product?, completion: @escaping ((Product?, Error?) -> Void)) {
        guard let kitura = kitura else {
            completion(nil, RequestError.internalServerError)
            return
        }
        
        kitura.post("/product", data: product) { (product: Product?, error: Error?) in
            completion(product, error)
        }
    }
    
    public func getProductsBy(venueId: String, completion: @escaping (([Product]?, RequestError?) -> Void)) {
        guard let kitura = kitura else {
            completion(nil, RequestError.internalServerError)
            return
        }
        
        kitura.get("/products", query: Product.Query(venueId: venueId)) { (products: [Product]?, error: RequestError?) in
            completion(products, error)
        }
    }
}

//MARK: Venues
extension ServerHandler {
    public func getAllVenues(completion: @escaping (([Venue]?, Error?) -> Void)) {
        guard let kitura = kitura else {
            completion(nil, RequestError.internalServerError)
            return
        }
        
        kitura.get("/venues/all") { (venues:[Venue]? , error: Error?) in
            completion(venues, error)
        }
    }
    
    public func post(venue: Venue?, completion: @escaping ((Venue?, Error?) -> Void)) {
        guard let kitura = kitura else {
            completion(nil, RequestError.internalServerError)
            return
        }
        
        kitura.post("/venue", data: venue) { (venue: Venue?, error: Error?) in
            completion(venue, error)
        }
    }
}

//MARK: Tour
extension ServerHandler {
    public func getAllTours(completion: @escaping (([Tour]?, Error?) -> Void)) {
        guard let kitura = kitura else {
            completion(nil, RequestError.internalServerError)
            return
        }
        
        kitura.get("/tours/all") { (tours:[Tour]? , error: Error?) in
            completion(tours, error)
        }
    }
    
    public func post(tour: Tour?, completion: @escaping ((Tour?, Error?) -> Void)) {
        guard let kitura = kitura else {
            completion(nil, RequestError.internalServerError)
            return
        }
        
        kitura.post("/tour", data: tour) { (tour: Tour?, error: Error?) in
            completion(tour, error)
        }
    }
}

//MARK: TourVenueLink
extension ServerHandler {
    public func getAllTourVenueLinks(completion: @escaping (([TourVenueLink]?, Error?) -> Void)) {
        guard let kitura = kitura else {
            completion(nil, RequestError.internalServerError)
            return
        }
        
        kitura.get("/tours/all") { (tours:[TourVenueLink]? , error: Error?) in
            completion(tours, error)
        }
    }
    
    public func post(tourVenueLink: TourVenueLink?, completion: @escaping ((TourVenueLink?, Error?) -> Void)) {
        guard let kitura = kitura else {
            completion(nil, RequestError.internalServerError)
            return
        }
        
        kitura.post("/tourVenueLink", data: tourVenueLink) { (tourVenueLink: TourVenueLink?, error: Error?) in
            completion(tourVenueLink, error)
        }
    }
}

