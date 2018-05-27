//
//  TourImage.swift
//  Application
//
//  Created by Lucas Assis Rodrigues on 25/05/2018.
//

import Foundation
import KituraKit

struct TourImage: Codable {
    var tourId: String
    var image: Data
    
    init?(tourId: String, image: Data) {
        self.tourId = tourId
        self.image = image
    }
    
    struct Query: QueryParams {
        var tourId: String?
    }
}

extension TourImage: Equatable {
    public static func ==(lhs: TourImage, rhs: TourImage) -> Bool {
        return lhs.image == rhs.image && lhs.image == rhs.image
    }
}
