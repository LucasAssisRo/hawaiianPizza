//
//  Product.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 08/05/2018.
//

import Foundation
import KituraKit

struct Product: Codable {
    var productId: String
    var venueId: String
    var name: String
    var description: String
    
    init?(productId: String, venueId: String, name: String, description: String) {
        self.productId = productId
        self.venueId = venueId
        self.name = name
        self.description = description
    }
    
    struct Query: QueryParams {
        var productId: String?
        var venueId: String?
        
        init(productId: String? = nil, venueId: String? = nil) {
            self.productId = productId
            self.venueId = venueId
        }
    }
}

extension Product: Equatable {
    public static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.productId == rhs.productId && lhs.productId == rhs.productId
    }
}
