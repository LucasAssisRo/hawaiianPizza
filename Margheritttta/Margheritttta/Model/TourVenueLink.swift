//
//  TourVenueLink.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 11/05/2018.
//

import Foundation
import KituraKit

struct TourVenueLink: Codable {
    public var tourId: String
    public var venueId: String
    
    public init?(tourId: String, venueId: String) {
        self.tourId = tourId
        self.venueId = venueId
    }
    
    struct Query: QueryParams {
        var tourId: String?
        var venueId: String?
    }
}
