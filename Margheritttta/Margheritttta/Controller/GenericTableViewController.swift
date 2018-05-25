//
//  GenericTableViewController.swift
//  Margheritttta
//
//  Created by Lucas Assis Rodrigues on 25/05/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class GenericTableViewController: UITableViewController {}

extension GenericTableViewController: TableViewCellDelegate {
    func performSegue() {
        print("TableViewCellDelegate")
    }
}
