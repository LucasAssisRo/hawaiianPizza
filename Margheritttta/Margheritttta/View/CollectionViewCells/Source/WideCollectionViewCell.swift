//
//  WideCollectionViewCell.swift
//  Margheritttta
//
//  Created by Alexander Schülke on 21.05.18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import Foundation
import UIKit

class WideCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var item: ItemView!
    @IBOutlet weak var thumbnailImageView: RoundImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var icon: UIButton!
    
    @IBAction func iconClicked(_ sender: Any) {
        print(self.icon.tag)
        if self.icon.tag > 1000 {
            self.icon.setBackgroundImage(UIImage(named: "heart2"), for: .normal)
            self.item.deletFromfavorites()
            
            // C processing tactics for the win .. *COUGH
            self.icon.tag -= 1000
        } else {
            print("fill")
            self.icon.setBackgroundImage(UIImage(named: "heart_filled_2"), for: .normal)
            self.item.setFavorite()
            
            // C processing tactics for the win .. *COUGH
            self.icon.tag += 1000
        }
    }
    
}
