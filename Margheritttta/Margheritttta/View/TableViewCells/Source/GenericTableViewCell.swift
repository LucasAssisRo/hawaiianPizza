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
        guard let item = sender.view as? ItemView,
            let id = item.id
            else {
                return
        }

        item.delegate?.performSegue(id: id)
    }
//
//    @IBAction func setFavorite(_ sender: UITapGestureRecognizer) {
//        guard let icon = sender.view as? FavoriteIcon else { return }
//        icon.image = UIImage(named: "heart_filled")
//    }
    
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
<<<<<<< HEAD
        case .saved:
            for images in SavedTableViewController.venueImages {
                if let venueId = images.first??.venueId,
                    venueId == id {
                    return images
                }
            }
||||||| merged common ancestors
=======
        case .saved:
            break
>>>>>>> 751c7e53d6c8d53555ce48aa53ae1d1d66522407
        }
        return []
    }
    
}

extension GenericTableViewCell: ItemDelegate {
    func performSegue(id: String) {
        self.delegate?.performSegue(id: id)
    }
}
