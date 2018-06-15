//
//  TourRoute.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 25/05/2018.
//

import Foundation
import KituraKit

struct TourRoute: Codable {
    var tourId: String
    var latitude: Double
    var longitude: Double
    
    init?(tourId: String, latitude: Double, longitude: Double) {
        self.tourId = tourId
        self.latitude = latitude
        self.longitude = longitude
    }
    
    struct Query: QueryParams {
        var tourId: String?
        var latitude: Double?
        var longitude: Double?
    }
}

extension TourRoute: Equatable {
    public static func ==(lhs: TourRoute, rhs: TourRoute) -> Bool {
        return (lhs.latitude == rhs.latitude && lhs.latitude == rhs.latitude) &&
            (lhs.longitude == rhs.longitude && lhs.longitude == rhs.longitude)
    }
}
