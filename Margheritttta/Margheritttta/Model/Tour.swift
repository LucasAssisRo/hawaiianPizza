//
//  Tour.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 11/05/2018.
//

import UIKit

struct Tour: Codable {
    
    private var images: Data
    private var route: Data

    public var tourId: String
    public var name: String
    public var description: String
    public var milestones: Int
    public var duration: Int
    
    public var imagesDecoded: [UIImage]? {
        return NSKeyedUnarchiver.unarchiveObject(with: self.images) as? [UIImage]
    }
    
    public var routeDecoded: [String]? {
        return NSKeyedUnarchiver.unarchiveObject(with: self.route) as? [String]
    }
    
    public init?(tourId: String, name: String, images: Data, description: String, milestones: Int, duration: Int, route: Data) {
        self.tourId = tourId
        self.name = name
        self.images = images
        self.description = description
        self.milestones = milestones
        self.duration = duration
        self.route = route
    }
}

extension Tour: Equatable {
    public static func ==(lhs: Tour, rhs: Tour) -> Bool {
        return lhs.tourId == rhs.tourId && lhs.tourId == rhs.tourId
    }
}
