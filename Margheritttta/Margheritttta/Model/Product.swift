//
//  Product.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 08/05/2018.
//

import UIKit

struct Product: Codable {
    
    private var images: Data
    private var allergens: Data
    
    public var productId: String
    public var venueId: String
    public var name: String
    public var description: String
    
    public var imagesDecoded: [UIImage]? {
        return NSKeyedUnarchiver.unarchiveObject(with: self.images) as? [UIImage]
    }
    
    public var allergensDecoded: [String]? {
        return NSKeyedUnarchiver.unarchiveObject(with: self.allergens) as? [String]
    }
    
    public init?(productId: String, venueId: String, name: String, images: Data, allergens: Data, description: String) {
        self.productId = productId
        self.venueId = venueId
        self.name = name
        self.images = images
        self.allergens = allergens
        self.description = description
    }
}

extension Product: Equatable {
    public static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.productId == rhs.productId && lhs.productId == rhs.productId
    }
}
