//
//  WideShopsTableCell.swift
//  Margheritttta
//
//  Created by Alexander Schülke on 21.05.18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class MixedShopsTableCell: GenericTableViewCell {
    
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
        case top = 0
        case left = 1
        case right = 2
    }
    
    @IBAction func wideIconClicked(_ sender: Any) {
        if self.icons[0].tag > 1000 {
            self.icons[0].setBackgroundImage(UIImage(named: "heart2"), for: .normal)
            self.items[0].deletFromfavorites()
            self.icons[0].tag -= 1000
        } else {
            self.icons[0].setBackgroundImage(UIImage(named: "heart_filled_2"), for: .normal)
            self.items[0].setFavorite()
            self.icons[0].tag += 1000
        }
    }
    
    @IBAction func leftIconClicked(_ sender: Any) {
        if self.icons[1].tag > 1000 {
            self.icons[1].setBackgroundImage(UIImage(named: "heart2"), for: .normal)
            self.items[1].deletFromfavorites()
            self.icons[1].tag -= 1000
        } else {
            self.icons[1].setBackgroundImage(UIImage(named: "heart_filled_2"), for: .normal)
            self.items[1].setFavorite()
            self.icons[1].tag += 1000
        }
    }
    
    @IBAction func rightIconClicked(_ sender: Any) {
        if self.icons[2].tag > 1000 {
            self.icons[2].setBackgroundImage(UIImage(named: "heart2"), for: .normal)
            self.items[2].deletFromfavorites()
            self.icons[2].tag -= 1000
        } else {
            self.icons[2].setBackgroundImage(UIImage(named: "heart_filled_2"), for: .normal)
            self.items[2].setFavorite()
            self.icons[2].tag += 1000
        }
    }
    
    
    
}
