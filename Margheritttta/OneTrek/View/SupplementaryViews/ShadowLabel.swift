//
//  ShadowLabel.swift
//  Margheritttta
//
//  Created by Lucas Assis Rodrigues on 15/06/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowLabel: UILabel {
    @IBInspectable var masksToBounds: Bool = false {
        didSet {
            self.layer.masksToBounds = self.masksToBounds
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable override var shadowOffset: CGSize {
        didSet {
            self.layer.shadowOffset = self.shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = self.shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = self.shadowOpacity
        }
    }
    
    @IBInspectable override var shadowColor: UIColor? {
        didSet {
            self.layer.shadowColor = self.shadowColor?.cgColor
        }
    }
}
