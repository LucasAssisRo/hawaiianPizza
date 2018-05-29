//
//  GenericTableViewController.swift
//  Margheritttta
//
//  Created by Lucas Assis Rodrigues on 25/05/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class GenericTableViewController: UITableViewController {
    var clickedId: String?
}

extension GenericTableViewController: TableViewCellDelegate {
    @objc func performSegue(id: String) {
        self.clickedId = id
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShopDetails" {
            let vc = segue.destination as! StoreViewController
            vc.venueId = self.clickedId
        }
    }
}
