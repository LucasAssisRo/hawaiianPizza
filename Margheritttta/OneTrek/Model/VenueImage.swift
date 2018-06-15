//
//  VenueImage.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 25/05/2018.
//

import Foundation
import KituraKit

struct VenueImage: Codable {
    var venueId: String
    var image: Data
    
    init?(venueId: String, image: Data) {
        self.venueId = venueId
        self.image = image
    }
    
    struct Query: QueryParams {
        var venueId: String?
    }
}

extension VenueImage: Equatable {
    public static func ==(lhs: VenueImage, rhs: VenueImage) -> Bool {
        return lhs.image == rhs.image && lhs.image == rhs.image
    }
}
