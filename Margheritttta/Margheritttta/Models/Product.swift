//
//  Product.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 08/05/2018.
//

import Foundation
import SwiftKueryORM

struct Product: Codable {
    var productId: String
    var venueId: String
    var name: String
    var images: Data // [UIImage]
    var allergens: Data // [String]
    var description: String
    
    init?(venueId: String, name: String, images: Data, allergens: Data, description: String) {
        self.venueId = venueId
        self.name = name
        self.allergens = allergens
        self.description = description
        self.images = images
        
        // Generate random id - not tested completely - not working
        self.productId = "\(self.name.hashValue)\(self.images.hashValue)\(self.description.hashValue)"
    }
    
    struct Query: QueryParams {
        var productId: String?
        var venueId: String?
        var name: String?
        var images: Data?
        var allergens: Data?
        var description: String?
    }
    
    struct Short: Codable {
        var productId: String
        var name: String?
        var images: String?
    }
}

extension Product: Model { }

extension Product: Equatable {
    public static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.productId == rhs.productId && lhs.productId == rhs.productId
    }
}
