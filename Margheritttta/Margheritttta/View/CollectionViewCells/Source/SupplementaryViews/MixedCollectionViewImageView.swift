//
//  MixedShopsImageView.swift
//  Margheritttta
//
//  Created by Alexander Schülke on 22.05.18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import Foundation
import UIKit

class MixedCollectionViewImageView: UIImageView {
    @IBInspectable var roundedCorners: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = roundedCorners
        }
    }
}
