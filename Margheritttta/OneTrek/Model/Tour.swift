//
//  Tour.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 11/05/2018.
//

import Foundation
import KituraKit

struct Tour: Codable {
    var tourId: String 
    var name: String
    var description: String
    var milestones: Int
    var duration: Int
    var city: String
    var country: String
    
    init?(tourId: String, name: String, description: String, milestones: Int, duration: Int, city: String, country: String) {
        self.tourId = tourId
        self.name = name
        self.description = description
        self.milestones = milestones
        self.duration = duration
        self.city = city
        self.country = country
    }
    
    struct Query: QueryParams {
        var tourId: String?
        var city: String?
        var country: String?
    }
}

extension Tour: Equatable {
    public static func ==(lhs: Tour, rhs: Tour) -> Bool {
        return lhs.tourId == rhs.tourId && lhs.tourId == rhs.tourId
    }
}
