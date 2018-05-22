//
//  Product.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 08/05/2018.
//

import UIKit

struct Product: Codable {
    var productId: String
    var venueId: String
    var name: String
    var images: [UIImage]
    var allergens: [String]
    var description: String
    
    init?(productId: String, venueId: String, name: String, images: Data, allergens: Data, description: String) {
        guard let images = NSKeyedUnarchiver.unarchiveObject(with: images) as? [UIImage],
            let allergens = NSKeyedUnarchiver.unarchiveObject(with: allergens) as? [String] else {
            return nil
        }
        
        self.productId = productId
        self.venueId = venueId
        self.name = name
        self.images = images
        self.allergens = allergens
        self.description = description
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.productId = try container.decode(String.self, forKey: .productId)
        self.venueId = try container.decode(String.self, forKey: .venueId)
        self.name = try container.decode(String.self, forKey: .name)
        self.images = NSKeyedUnarchiver.unarchiveObject(with: try container.decode(Data.self,
                                                                                   forKey: .images)) as! [UIImage] 
        self.allergens = try container.decode([String].self, forKey: .allergens)
        self.description = try container.decode(String.self, forKey: .description)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.productId, forKey: .productId)
        try container.encode(self.venueId, forKey: .venueId)
        try container.encode(self.name, forKey: .name)
        try container.encode(NSKeyedArchiver.archivedData(withRootObject: self.images), forKey: .images)
        try container.encode(self.allergens, forKey: .allergens)
        try container.encode(self.description, forKey: .description)
    }
    
    public enum CodingKeys: String, CodingKey {
        case productId
        case venueId
        case name
        case images
        case allergens
        case description
    }
}

extension Product: Equatable {
    public static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.productId == rhs.productId && lhs.productId == rhs.productId
    }
}
