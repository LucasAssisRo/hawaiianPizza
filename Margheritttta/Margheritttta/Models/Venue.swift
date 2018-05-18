//
//  Venue.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 11/05/2018.
//

import Foundation
import SwiftKueryORM

struct Venue: Codable {
    var venueId: String
    var name: String
    var images: Data // [UIImage]
    var description: String
    var category: String
    var tags: Data // [String]
    var address1: String
    var address2: String?
    var city: String
    var country: String
    var zipCode: String
    var phone: String?
    var email: String?
    
    init?(venueId: String, name: String, images: Data, description: String, category: String, tags: Data, address1: String, address2: String?, city: String, country: String, zipCode: String, phone: String?, email: String?) {
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
    
    struct Query: QueryParams {
        var venueId: String?
        var name: String?
        var images: Data?
        var description: String?
        var category: String?
        var tags: Data?
        var address1: String?
        var address2: String?
        var city: String?
        var country: String?
        var zipCode: String?
        var phone: Int?
        var email: String?
    }
    
    struct Short: Codable {
        var venueId: String
        var name: String?
        var images: String? // [UIImage]
        var tags: String? // [String]
        var address1: String?
        var address2: String?
        var city: String?
        var country: String?
        var zipCode: String?
        
        init(venueId: String, name: String? = nil, images: String? = nil, tags: String? = nil, address1: String? = nil, address2: String? = nil, city: String? = nil, country: String? = nil, zipCode: String? = nil) {
            self.venueId = venueId
            self.name = name
            self.images = images
            self.tags = tags
            self.address1 = address1
            self.address2 = address2
            self.city = city
            self.country = country
            self.zipCode = zipCode
        }
    }
}



extension Venue: Model {}

extension Venue: Equatable {
    public static func ==(lhs: Venue, rhs: Venue) -> Bool {
        return lhs.venueId == rhs.venueId && lhs.venueId == rhs.venueId
    }
}
