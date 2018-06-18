//
//  SpringTableViewCell.swift
//  OneTrek
//
//  Created by Lucas Assis Rodrigues on 15/06/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class SpringTableViewCell: UITableViewCell {

    @IBOutlet weak var springView: SpringView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
