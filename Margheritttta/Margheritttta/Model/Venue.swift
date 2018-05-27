//
//  Venue.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 11/05/2018.
//

import Foundation
import KituraKit

struct Venue: Codable {
    var venueId: String
    var name: String
    var description: String
    var category: String
    var address1: String
    var address2: String?
    var city: String
    var country: String
    var zipCode: String
    var phone: String?
    var email: String?
    
    init?(venueId: String, name: String, description: String, category: String, address1: String, address2: String?, city: String, country: String, zipCode: String, phone: String?, email: String?) {
        self.venueId = venueId
        self.name = name
        self.description = description
        self.category = category
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
        var address1: String?
        var address2: String?
        var city: String?
        var country: String?
        var zipCode: String?
    }
}

extension Venue: Equatable {
    public static func ==(lhs: Venue, rhs: Venue) -> Bool {
        return lhs.venueId == rhs.venueId && lhs.venueId == rhs.venueId
    }
}
