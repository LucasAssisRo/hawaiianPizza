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
}