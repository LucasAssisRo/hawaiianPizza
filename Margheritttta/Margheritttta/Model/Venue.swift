//
//  Venue.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 11/05/2018.
//

import UIKit

struct Venue: Codable {
    private var images: Data
    private var tags: Data
    
    public var venueId: String
    public var name: String
    public var description: String
    public var category: String
    public var address1: String
    public var address2: String?
    public var city: String
    public var country: String
    public var zipCode: String
    public var phone: String?
    public var email: String?
    
    public var imagesDecoded: [UIImage]? {
        return NSKeyedUnarchiver.unarchiveObject(with: self.images) as? [UIImage]
    }

    public var tagsDecoded: [String]? {
        return NSKeyedUnarchiver.unarchiveObject(with: self.tags) as? [String]
    }
    
    public init?(venueId: String, name: String, images: Data, description: String, category: String, tags: Data, address1: String, address2: String?, city: String, country: String, zipCode: String, phone: String?, email: String?) {
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
}

extension Venue: Equatable {
    public static func ==(lhs: Venue, rhs: Venue) -> Bool {
        return lhs.venueId == rhs.venueId && lhs.venueId == rhs.venueId
    }
}
