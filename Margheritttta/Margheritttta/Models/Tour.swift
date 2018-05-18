//
//  Tour.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 11/05/2018.
//

import Foundation
import SwiftKueryORM

struct Tour: Codable {
    var tourId: String 
    var name: String
    var images: Data // [UIImage]
    var description: String
    var milestones: Int
    var duration: Int // [String]
    var route: Data // [Coordinates]
    
    init?(tourId: String, name: String, images: Data, description: String, milestones: Int, duration: Int, route: Data) {
        self.tourId = tourId
        self.name = name
        self.images = images
        self.description = description
        self.milestones = milestones
        self.duration = duration
        self.route = route
    }
    
    struct Query: QueryParams {
        var tourId: String?
        var name: String?
        var images: Data?
        var description: String?
        var milestones: Int?
        var duration: Int?
        var route: Data?
    }
}

extension Tour: Model {}

extension Tour: Equatable {
    public static func ==(lhs: Tour, rhs: Tour) -> Bool {
        return lhs.tourId == rhs.tourId && lhs.tourId == rhs.tourId
    }
}
