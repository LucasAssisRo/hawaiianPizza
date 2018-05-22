//
//  Tour.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 11/05/2018.
//

import UIKit

struct Tour: Codable {
    var tourId: String 
    var name: String
    var images: [UIImage]
    var description: String
    var milestones: Int
    var duration: Int
    var route: [String]
    
    init?(tourId: String, name: String, images: Data, description: String, milestones: Int, duration: Int, route: Data) {
        guard let images = NSKeyedUnarchiver.unarchiveObject(with: images) as? [UIImage],
        let route = NSKeyedUnarchiver.unarchiveObject(with: route) as? [String] else {
            return nil
        }
        
        self.tourId = tourId
        self.name = name
        self.images = images
        self.description = description
        self.milestones = milestones
        self.duration = duration
        self.route = route
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tourId = try container.decode(String.self, forKey: .tourId)
        self.name = try container.decode(String.self, forKey: .name)
        self.images = try NSKeyedUnarchiver.unarchiveObject(with: container.decode(Data.self,
                                                                                   forKey: .images)) as! [UIImage]
        self.description = try container.decode(String.self, forKey: .description)
        self.milestones = try container.decode(Int.self, forKey: .milestones)
        self.duration = try container.decode(Int.self, forKey: .duration)
        self.route = try container.decode([String].self, forKey: .route)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.tourId, forKey: .tourId)
        try container.encode(self.name, forKey: .name)
        try container.encode(NSKeyedArchiver.archivedData(withRootObject: self.images), forKey: .images)
        try container.encode(self.name, forKey: .description)
        try container.encode(self.milestones, forKey: .milestones)
        try container.encode(self.duration, forKey: .duration)
        try container.encode(self.route, forKey: .route)
    }
    
    public enum CodingKeys: String, CodingKey {
        case tourId
        case name
        case images
        case description
        case milestones
        case duration
        case route
    }
}

extension Tour: Equatable {
    public static func ==(lhs: Tour, rhs: Tour) -> Bool {
        return lhs.tourId == rhs.tourId && lhs.tourId == rhs.tourId
    }
}
