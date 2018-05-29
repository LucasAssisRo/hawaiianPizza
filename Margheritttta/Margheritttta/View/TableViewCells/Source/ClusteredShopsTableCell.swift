//
//  ShopTableRow.swift
//  Margheritttta
//
//  Created by Alexander Schülke on 19.05.18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class ClusteredShopsTableCell: GenericTableViewCell {
    
    @IBOutlet var items: [ItemView]! {
        didSet {
            self.items.sort { first, second -> Bool in
                return first.tag < second.tag
            }
            
            for item in self.items {
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.selectItem(_:)))
                item.addGestureRecognizer(tap)
                item.delegate = self
                
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
    
    @IBOutlet var icons: [UIButton]! {
        didSet {
            self.icons.sort { first, second -> Bool in
                return first.tag < second.tag
            }
        }
    }
    
    @IBOutlet var thumbnailImageViews: [RoundImageView]! {
        didSet {
            self.thumbnailImageViews.sort { first, second -> Bool in
                return first.tag < second.tag
            }
        }
    }
    
    @IBOutlet var titleLabels: [UILabel]! {
        didSet {
            self.titleLabels.sort { first, second -> Bool in
                return first.tag < second.tag
            }
        }
    }
    
    @IBOutlet var subtitleLabels: [UILabel]! {
        didSet {
            self.subtitleLabels.sort { first, second -> Bool in
                return first.tag < second.tag
            }
        }
    }
    
    enum Position: Int {
        case topLeft = 0
        case topRight = 1
        case bottomLeft = 2
        case bottomRight = 3
    }
    @IBAction func topLeftIconClicked(_ sender: Any) {
        self.icons[0].setBackgroundImage(UIImage(named: "heart_filled_2"), for: .normal)
        self.items[0].setFavorite()
    }
    
    @IBAction func topRightIconClicked(_ sender: Any) {
        self.icons[1].setBackgroundImage(UIImage(named: "heart_filled_2"), for: .normal)
        self.items[1].setFavorite()
    }
    @IBAction func bottomLeftIconClicked(_ sender: Any) {
        self.icons[2].setBackgroundImage(UIImage(named: "heart_filled_2"), for: .normal)
        self.items[2].setFavorite()
    }
    @IBAction func bottomRightIconClicked(_ sender: Any) {
        self.icons[3].setBackgroundImage(UIImage(named: "heart_filled_2"), for: .normal)
        self.items[3].setFavorite()
    }
    


}
