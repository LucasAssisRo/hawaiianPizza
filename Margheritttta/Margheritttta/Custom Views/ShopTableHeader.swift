//
//  ShopTitleHeader.swift
//  Margheritttta
//
//  Created by Alexander Schülke on 20.05.18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import Foundation
import UIKit

class ShopTableHeader: UIView {

    @IBOutlet weak var rowTitle: UILabel!
    @IBOutlet weak var rowDescription: UILabel!
    var test: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
