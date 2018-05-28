//
//  GenericTableViewController.swift
//  Margheritttta
//
//  Created by Lucas Assis Rodrigues on 25/05/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class GenericTableViewCell: UITableViewCell {

    var delegate: TableViewCellDelegate?
    
    var venues: [Venue]?
    var venueImages: [[VenueImage]?] = []
    
    var tours: [Tour]?
    var tourImages: [[TourImage]?] = []
    
    var loadingImageIndex = -1
    
    @IBAction func selectItem(_ sender: UITapGestureRecognizer) {
        guard let item = sender.view as? ItemView else { return }

        item.delegate?.performSegue()
    }
}

extension GenericTableViewCell: ItemDelegate {
    func performSegue() {
        print("ItemDelegate")
        self.delegate?.performSegue()
    }
}
