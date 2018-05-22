//
//  TourVenueLink.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 11/05/2018.
//

import Foundation

struct TourVenueLink: Codable {
    public var tourId: String
    public var venueId: String
    
    public init?(tourId: String, venueId: String) {
        self.tourId = tourId
        self.venueId = venueId
    }
}
