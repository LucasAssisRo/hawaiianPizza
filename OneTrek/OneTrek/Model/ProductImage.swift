//
//  ProductImage.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 25/05/2018.
//

import Foundation
import KituraKit

struct ProductImage: Codable {
    var productId: String
    var image: Data
    
    init?(productId: String, image: Data) {
        self.productId = productId
        self.image = image
    }
    
    struct Query: QueryParams {
        var productId: String?
        var image: Data?
    }
}

extension ProductImage: Equatable {
    public static func ==(lhs: ProductImage, rhs: ProductImage) -> Bool {
        return lhs.image == rhs.image && lhs.image == rhs.image
    }
}
