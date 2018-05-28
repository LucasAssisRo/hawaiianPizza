//
//  ClusteredSkeletonTableCell.swift
//  Margheritttta
//
//  Created by Alexander Schülke on 27.05.18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import Foundation
import UIKit

class ClusteredSkeletonTableCell: UITableViewCell {
    
    @IBOutlet var items: [ItemView]! {
        didSet {
            for item in self.items {
                
                item.layer.cornerRadius = CGFloat(GlobalConstantss.cornerRadius)
                item.layer.masksToBounds = true
                
                item.layer.shadowColor = GlobalConstantss.shadowColor
                item.layer.shadowOffset = GlobalConstantss.shadowOffset
                item.layer.shadowRadius = CGFloat(GlobalConstantss.shadowradius)
                item.layer.shadowOpacity = 1.0
                item.layer.masksToBounds = false;
                item.layer.shadowPath = UIBezierPath(roundedRect:item.bounds, cornerRadius:item.layer.cornerRadius).cgPath
            }
        }
    }
    
    @IBOutlet var thumbnailImageViews: [UIView]!
    
    @IBOutlet var titleLabels: [UIView]!
    
    @IBOutlet var subtitleLabels: [UIView]!
    

}
