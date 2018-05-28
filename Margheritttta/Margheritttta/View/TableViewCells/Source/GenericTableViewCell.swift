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
    var contentType: ContentType = .venue

    @IBAction func selectItem(_ sender: UITapGestureRecognizer) {
        guard let item = sender.view as? ItemView else { return }

        item.delegate?.performSegue()
    }
    
    func findImages(by id: String) -> [VenueImage?]  {
        switch self.contentType {
        case .venue:
            for images in ExploreViewController.venueImages {
                if let venueId = images.first??.venueId,
                    venueId == id {
                    return images
                }
            }
            
        case .tour:
            break
        }
        
        return []
    }
}

extension GenericTableViewCell: ItemDelegate {
    func performSegue() {
        print("ItemDelegate")
        self.delegate?.performSegue()
    }
}
