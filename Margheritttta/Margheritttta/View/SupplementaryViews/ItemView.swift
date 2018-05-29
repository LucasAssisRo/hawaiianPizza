//
//  ItemView.swift
//  Margheritttta
//
//  Created by Lucas Assis Rodrigues on 25/05/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

@IBDesignable
class ItemView: UIView {
    
    var id: String?
    var delegate: ItemDelegate?
    
    override var bounds: CGRect {
        didSet {
            if self.layer.shadowPath != nil {
                self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                                     cornerRadius: self.cornerRadius).cgPath
            }
        }
    }
    
    @IBInspectable var masksToBounds: Bool = false {
        didSet {
            self.layer.masksToBounds = self.masksToBounds
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            if self.layer.shadowPath != nil {
                self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                                     cornerRadius: self.cornerRadius).cgPath
            }
        }
    }
    
    @IBInspectable var shadowColor: UIColor  = UIColor.clear {
        didSet {
            self.layer.shadowColor = self.shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = self.shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = self.shadowRadius
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            self.layer.shadowOffset = self.shadowOffset
        }
    }
}
