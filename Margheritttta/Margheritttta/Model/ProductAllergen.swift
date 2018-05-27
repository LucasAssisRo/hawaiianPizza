//
//  ProductAllegens.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 25/05/2018.
//

import Foundation
import KituraKit

struct ProductAllergen: Codable {
    var productId: String
    var allergen: String
    
    init?(productId: String, allergen: String) {
        self.productId = productId
        self.allergen = allergen
    }
    
    struct Query: QueryParams {
        var productId: String?
        var allergen: String?
    }
}

extension ProductAllergen: Equatable {
    public static func ==(lhs: ProductAllergen, rhs: ProductAllergen) -> Bool {
        return lhs.allergen == rhs.allergen && lhs.allergen == rhs.allergen
    }
}
