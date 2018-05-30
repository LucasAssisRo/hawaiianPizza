//
//  SavedTableViewController.swift
//  Margheritttta
//
//  Created by Lucas Assis Rodrigues on 22/05/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class SavedTableViewController: GenericTableViewController {
    
    @IBOutlet weak var contentSegmentedControl: UISegmentedControl!
    
    private let sectionsWithButton: [Int] = [0, 1]
    
    static var venues: [Venue]?
    static var venueImages: [[VenueImage?]] = []
    static var shopIds: [String] = []
    var finishedLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SHOPS
        self.tableView.register(LinearShopsTableCell.self,
                                forCellReuseIdentifier:"LinearShopsTableCell" )
        self.tableView.register(UINib(nibName: "LinearShopsTableCell", bundle: nil),
                                forCellReuseIdentifier: "LinearShopsTableCell")
        
        //TOURS
        self.tableView.register(WideShopsTableCell.self,
                                forCellReuseIdentifier:"WideShopsTableCell" )
        self.tableView.register(UINib(nibName: "WideShopsTableCell", bundle: nil),
                                forCellReuseIdentifier: "WideShopsTableCell")
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0.0, 0.0, 0.0)
        self.tableView.reloadData()
//        let kitura = ServerHandler.shared
//
//        let defaults = UserDefaults.standard
//        if let data = defaults.data(forKey: "savedShops"),
//            let savedShops = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] {
//            SavedTableViewController.venues = []
//            for shopId in savedShops {
//                kitura.getVenues(by: Venue.Query(venueId: shopId)) { venues, error in
//                    if let error = error {
//                        print(error.localizedDescription)
//                        return
//                    }
//
//                    guard let venues = venues else { return }
//                    for newVenue in venues {
//                        SavedTableViewController.venues?.append(newVenue)
//                        SavedTableViewController.shopIds.append(newVenue.venueId)
//                    }
//
//
//                    for venue in venues {
//                        kitura.getVenueImages(by: venue.venueId, completion: { images, error in
//                            if let error = error {
//                                print(error.localizedDescription)
//                                return
//                            }
//
//                            guard let images = images else { return }
//                            SavedTableViewController.venueImages.append(images)
//
//                            if SavedTableViewController.venueImages.count == venues.count {
//
//                                DispatchQueue.main.sync {
//                                    self.finishedLoading = true
//                                    self.tableView.reloadData()
//                                }
//                            }
//                        })
//                    }
//                }
//            }
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    @IBAction func changeContent(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch contentSegmentedControl.selectedSegmentIndex {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WideShopsTableCell", for: indexPath) as! WideShopsTableCell
            cell.registerNibThis()
            cell.delegate = self
            cell.contentType = .saved
            cell.collectionView.reloadData()
            cell.loaded = self.finishedLoading
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LinearShopsTableCell", for: indexPath) as! LinearShopsTableCell
            cell.registerNibThis()
            cell.delegate = self
            cell.contentType = .saved
            cell.collectionView.reloadData()
            cell.loaded = self.finishedLoading
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
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
            heading = "Bookmarked"
        case 1:
            heading = "Archived"
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
        button.layer.cornerRadius = 29
        button.layer.backgroundColor = UIColor.white.cgColor
        button.setTitleColor(GlobalConstantss.fontColor, for: .normal)
        button.setTitle(GlobalConstantss.buttonText, for: .normal)
        
        
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
        // Create the button for the footer view
        let button = self.getTableFooterButton(for: cell)
        
        if sectionsWithButton.contains(section) {
            // Assign a different tag to trigger different functionality in showMore()
            switch section {
            case 0:
                button.tag = 0
                button.addTarget(self, action: #selector(self.showMore(button:)), for: .touchUpInside)
            case 1:
                button.tag = 1
                button.addTarget(self, action: #selector(self.showMore(button:)), for: .touchUpInside)
            case 2:
                button.tag = 2
                button.addTarget(self, action: #selector(self.showMore(button:)), for: .touchUpInside)
            case 3:
                button.tag = 3
                button.addTarget(self, action: #selector(self.showMore(button:)), for: .touchUpInside)
            default:
                break
            }
            
            cell.addSubview(button)
            
            // Assign constraints
            self.createConstants(for: button, with: cell)
        }
        
        //        return cell
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if sectionsWithButton.contains(section) {
            //            return 160
            return 0
        } else {
            return 0
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
        case 2:
            print("Section 2 button clicked")
        case 3:
            print("Section 3 button clicked")
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
    
    
    override func performSegue(id: String) {
        super.performSegue(id: id)
        self.performSegue(withIdentifier: "ShopDetails", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.finishedLoading = false
        self.tableView.reloadData()
        self.getStoresFromDatabase()
    }
    
    private func getStoresFromDatabase() {
        let kitura = ServerHandler.shared
        
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: "savedShops"),
            let savedShops = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] {
            SavedTableViewController.venues = []
            SavedTableViewController.venueImages = []
            for shopId in savedShops {
                kitura.getVenues(by: Venue.Query(venueId: shopId)) { venues, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    guard let venues = venues else { return }
                    for newVenue in venues {
                        SavedTableViewController.venues?.append(newVenue)
                        SavedTableViewController.shopIds.append(newVenue.venueId)
                    }
                    
                    for venue in venues {
                        kitura.getVenueImages(by: venue.venueId, completion: { images, error in
                            if let error = error {
                                print(error.localizedDescription)
                                return
                            }
                            guard let images = images else { return }
                            SavedTableViewController.venueImages.append(images)
                            if SavedTableViewController.venueImages.count == SavedTableViewController.venues?.count {
                                
                                DispatchQueue.main.sync {
                                    self.finishedLoading = true
                                    self.tableView.reloadData()
                                }
                            }
                        })
                    }
                }
            }
        }
    }
    
}
