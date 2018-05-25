//
//  SearchToursViewController.swift
//  Margheritttta
//
//  Created by Marco Romano on 02/05/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class SearchToursViewController: UITableViewController {
    
    // The index of the sections that should contain a "See all tours button"
    private let sectionsWithButtons = [1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(CoverTableCell.self,
                                forCellReuseIdentifier:"CoverTableCell" )
        self.tableView.register(UINib(nibName: "CoverTableCell", bundle: nil),
                                forCellReuseIdentifier: "CoverTableCell")
        
        self.tableView.register(WideShopsTableCell.self,
                                forCellReuseIdentifier:"WideShopsTableCell" )
        self.tableView.register(UINib(nibName: "WideShopsTableCell", bundle: nil),
                                forCellReuseIdentifier: "WideShopsTableCell")
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0.0, 0.0, 0.0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoverTableCell", for: indexPath) as! CoverTableCell
            cell.registerNibThis()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WideShopsTableCell", for: indexPath) as! WideShopsTableCell
            cell.registerNibThis()
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoverTableCell", for: indexPath) as! CoverTableCell
            cell.registerNibThis()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 230
        case 1:
            return 185
        default:
            return 185
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    /**
     Create a header view for each section. As it was not possible for us to use IBOutlets, the according
     heading gets created by code.
     
     - Author:
     Alexander Schülke
     */
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Get width and height for header view
        let headerFrame = tableView.frame
        
        // Create the subview labels for the headerview
        let title = UILabel()
        title.frame = CGRect(x: 10, y: 0, width: headerFrame.size.width-20, height: 20)
        title.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        
        
        // Get the according texts for the sections
        title.text = self.getHeadingForSection(section)
        
        // Create the header view
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: headerFrame.size.width, height: headerFrame.size.height))
        
        // Add subviews
        headerView.addSubview(title)
        
        return headerView
    }
    
    
    /**
     Returns the according heading text for the section. At the moment the order of the sections is static,
     for the future more dynamic implementations might be necessary.
     
     - Author
     Alexander Schülke
     
     - parameters:
     - section: The number of the section the title should be created for
     
     - returns:
     The accordig title for the section
     */
    private func getHeadingForSection(_ section: Int) -> String {
        var heading = ""
        switch section {
        case 0:
            heading = "My Location"
        case 1:
            heading = "Other cities with tours"
        default:
            heading = ""
        }
        return heading.uppercased()
    }
    
    
    /**
     Creates the button for the section footer.
     
     - Author:
     Alexander Schülke
     
     - parameters:
     - footer: The footer the button should get created for.
     
     - returns:
     The new button for the footer
     */
    private func getTableFooterButton(for footer: ShopTableFooter) -> UIButton {
        let button = UIButton(frame: CGRect(x: footer.frame.width/2-110, y: 40, width: 200, height: 40))
        
        // Button details
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.setTitle("See all tours", for: .normal)
        
        return button
    }
    
    /**
     Create a footer view for each section. As it was not possible for us to use IBOutlets, the button
     and the executable action have to be created by code.
     
     - Author
     Alexander Schülke
     */
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // Get width and height for header view
        let footerFrame = tableView.frame
        
        // Create the actual footer view
        let cell = ShopTableFooter(frame: CGRect(x: 0, y: 0, width: footerFrame.width, height: 0))
        
        if sectionsWithButtons.contains(section) {
            
            // Create the button for the footer view
            let button = self.getTableFooterButton(for: cell)
            
            // Assign a different tag to trigger different functionality in showMore()
            switch section {
            case 0:
                button.tag = 0
                button.addTarget(self, action: #selector(self.showMore(button:)), for: .touchUpInside)
            case 1:
                button.tag = 1
                button.addTarget(self, action: #selector(self.showMore(button:)), for: .touchUpInside)
            default:
                break
            }
            
            cell.addSubview(button)
            
            // Assign constraints
            self.createConstants(for: button, with: cell)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if sectionsWithButtons.contains(section) {
            return 100
        } else {
            return 40
        }
    }
    
    /**
     Additional functionality for the button. Necessary because we cannot use IBActions
     
     - Author:
     Alexander Schülke
     
     - parameters:
     - button: The button to assign the actions to
     */
    @objc private func showMore(button: UIButton) {
        switch button.tag {
        case 0:
            print("Section 0 button clicked")
        case 1:
            print("Section 1 button clicked")
        default:
            return
        }
    }
    
    
    /**
     Places the button into the right position
     
     - Author:
     Alexander Schülke
     
     - parameters:
     - button: The button to position
     - footer: The footer in which the button should be positioned
     */
    private func createConstants(for button: UIButton, with footer: ShopTableFooter) {
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: footer.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: footer.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 180).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
}

