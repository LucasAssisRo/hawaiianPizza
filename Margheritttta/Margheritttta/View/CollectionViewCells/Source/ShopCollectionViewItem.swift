//
//  ShopCollectionViewItem.swift
//  Margheritttta
//
//  Created by Alexander Schülke on 19.05.18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class ShopCollectionViewItem: UICollectionViewCell {
    @IBOutlet weak var item: ItemView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
