//
//  VenueTag.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 25/05/2018.
//

import Foundation
import KituraKit

struct VenueTag: Codable {
    var venueId: String
    var tag: String
    
    init?(venueId: String, tag: String) {
        self.venueId = venueId
        self.tag = tag
    }
    
    struct Query: QueryParams {
        var venueId: String?
        var tag: String?
    }
}

extension VenueTag: Equatable {
    public static func ==(lhs: VenueTag, rhs: VenueTag) -> Bool {
        return lhs.tag == rhs.tag && lhs.tag == rhs.tag
    }
}
