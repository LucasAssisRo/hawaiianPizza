//
//  Venue.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 11/05/2018.
//

import UIKit

struct Venue: Codable {
    var venueId: String
    var name: String
    var images: [UIImage]
    var description: String
    var category: String
    var tags: [String]
    var address1: String
    var address2: String?
    var city: String
    var country: String
    var zipCode: String
    var phone: String?
    var email: String?
    
    init?(venueId: String, name: String, images: Data, description: String, category: String, tags: Data, address1: String, address2: String?, city: String, country: String, zipCode: String, phone: String?, email: String?) {
        guard let images = NSKeyedUnarchiver.unarchiveObject(with: images) as? [UIImage],
            let tags = NSKeyedUnarchiver.unarchiveObject(with: tags) as? [String] else {
                return nil
        }
        
        self.venueId = venueId
        self.name = name
        self.images = images
        self.description = description
        self.category = category
        self.tags = tags
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.country = country
        self.zipCode = zipCode
        self.phone = phone
        self.email = email
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.venueId = try container.decode(String.self, forKey: .venueId)
        self.name = try container.decode(String.self, forKey: .name)
        self.images = try NSKeyedUnarchiver.unarchiveObject(with: container.decode(Data.self,
                                                                                   forKey: .images)) as! [UIImage]
        self.description = try container.decode(String.self, forKey: .description)
        self.category = try container.decode(String.self, forKey: .category)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.address1 = try container.decode(String.self, forKey: .address1)
        self.address2 = try container.decode(String?.self, forKey: .address2)
        self.city = try container.decode(String.self, forKey: .city)
        self.country = try container.decode(String.self, forKey: .country)
        self.zipCode = try container.decode(String.self, forKey: .zipCode)
        self.phone = try container.decode(String?.self, forKey: .phone)
        self.email = try container.decode(String?.self, forKey: .email)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.venueId, forKey: .venueId)
        try container.encode(self.name, forKey: .name)
        try container.encode(NSKeyedArchiver.archivedData(withRootObject: self.images), forKey: .images)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.category, forKey: .category)
        try container.encode(self.tags, forKey: .tags)
        try container.encode(self.address1, forKey: .address1)
        try container.encode(self.address2, forKey: .address2)
        try container.encode(self.city, forKey: .city)
        try container.encode(self.country, forKey: .country)
        try container.encode(self.zipCode, forKey: .zipCode)
        try container.encode(self.phone, forKey: .phone)
        try container.encode(self.email, forKey: .email)
    }
    
    public enum CodingKeys: String, CodingKey {
        case venueId
        case name
        case images
        case description
        case category
        case tags
        case address1
        case address2
        case city
        case country
        case zipCode
        case phone
        case email
    }
}

extension Venue: Equatable {
    public static func ==(lhs: Venue, rhs: Venue) -> Bool {
        return lhs.venueId == rhs.venueId && lhs.venueId == rhs.venueId
    }
}
