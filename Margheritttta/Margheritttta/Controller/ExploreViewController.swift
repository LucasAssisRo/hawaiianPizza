//
//  ExploreViewController.swift
//  Margheritttta
//
//  Created by Marco Romano on 27/04/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class ExploreViewController: GenericTableViewController {
    
    private let sectionsWithButton: [Int] = [0, 1]
    
    static var venues: [Venue]?
    static var venueImages: [[VenueImage?]] = []
    
    private var mixedLoaded = false
    var mixedTimer: Timer!
    private var clusteredLoaded = false
    var clusteredTimer: Timer!
    
    var finishedLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up NIBs
        self.tableView.register(LinearShopsTableCell.self, forCellReuseIdentifier: "LinearShopsTableCell")
        self.tableView.register(UINib(nibName: "LinearShopsTableCell", bundle: nil), forCellReuseIdentifier: "LinearShopsTableCell")
        self.tableView.register(WideShopsTableCell.self, forCellReuseIdentifier: "WideShopsTableCell")
        self.tableView.register(UINib(nibName: "WideShopsTableCell", bundle: nil), forCellReuseIdentifier: "WideShopsTableCell")
        self.tableView.register(MixedShopsTableCell.self, forCellReuseIdentifier: "MixedShopsTableCell")
        self.tableView.register(UINib(nibName: "MixedShopsTableCell", bundle: nil), forCellReuseIdentifier: "MixedShopsTableCell")
        self.tableView.register(ClusteredShopsTableCell.self, forCellReuseIdentifier: "ClusteredShopsTableCell")
        self.tableView.register(UINib(nibName: "ClusteredShopsTableCell", bundle: nil), forCellReuseIdentifier: "ClusteredShopsTableCell")
        self.tableView.register(MixedSkeletonTableCell.self, forCellReuseIdentifier: "MixedSkeletonTableCell")
        self.tableView.register(UINib(nibName: "MixedSkeletonTableCell", bundle: nil), forCellReuseIdentifier: "MixedSkeletonTableCell")
        self.tableView.register(ClusteredSkeletonTableCell.self, forCellReuseIdentifier: "ClusteredSkeletonTableCell")
        self.tableView.register(UINib(nibName: "ClusteredSkeletonTableCell", bundle: nil), forCellReuseIdentifier: "ClusteredSkeletonTableCell")
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0.0, 0.0, 0.0)
        
        let kitura = ServerHandler.shared
        
        ExploreViewController.venueImages.removeAll()
        kitura.getAllVenues { venues, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let venues = venues else { return }
            ExploreViewController.venues = venues
            for venue in venues {
                kitura.getVenueImages(by: venue.venueId, completion: { images, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    guard let images = images else { return }
                    ExploreViewController.venueImages.append(images)
                    
                    if ExploreViewController.venueImages.count == venues.count {
                        DispatchQueue.main.sync {
                            print("reload")
                            self.finishedLoading = true
                            self.tableView.reloadData()
                        }
                    }
                })
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 185
        case 1:
            return 170
        case 2:
            return 427
        case 3:
            return 427
        default:
            return 180
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
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
        title.textColor = UIColor.titleColor
        let description = UILabel()
        description.frame = CGRect(x: 10, y: 28, width: headerFrame.size.width-20, height: 20)
        description.textColor = UIColor.subtitleColor
        
        // Get the according texts for the sections
        title.text = self.getHeadingForSection(section)
        description.text = self.getDescriptionForSection(section)
        
        // Hide description element if no description provided
        if description.text == "" {
            description.isHidden = true
        }
        
        // Create the header view
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: headerFrame.size.width, height: headerFrame.size.height))
        
        // Add subviews
        headerView.addSubview(title)
        headerView.addSubview(description)
        
        return headerView
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
            heading = "Shops near you"
        case 1:
            heading = "Other Shops"
        case 2:
            heading = "Stacked Shops"
        case 3:
            heading = "Clustered Shops"
        default:
            heading = ""
        }
        return heading.uppercased()
    }
    
    /**
     Returns the according description text for the section. At the moment the order of the sections is static,
     for the future more dynamic implementations might be necessary.
     
     - Author
     Alexander Schülke
     
     - parameters:
     - section: The number of the section the description should be created for
     
     - returns:
     The accordig description for the section
     */
    private func getDescriptionForSection(_ section: Int) -> String {
        var description = ""
        switch section {
        case 0:
            description = "Check out the new amazing stores"
        case 1:
            description = "Visit some other doofy stores"
        case 2:
            description = "Some wrapped up stores"
        case 3:
            description = "You see all those clusters?"
        default:
            description = ""
        }
        
        return description
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
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        button.layer.shadowColor = UIColor(red: 209/255, green: 214/255, blue: 220/255, alpha: 140/255).cgColor
        button.layer.shadowOffset = CGSize(width:0,height: 18.0)
        button.layer.shadowRadius = 13.0
        button.layer.shadowOpacity = 1.0
        button.layer.masksToBounds = false;
        button.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: button.bounds.minX, y: button.bounds.minY-10, width: button.bounds.maxX, height: button.bounds.maxY + 20), cornerRadius:button.layer.cornerRadius).cgPath
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LinearShopsTableCell") as! LinearShopsTableCell
            cell.registerNibThis()
            cell.delegate = self
            cell.contentType = .venue
            cell.collectionView.reloadData()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WideShopsTableCell") as! WideShopsTableCell
            cell.registerNibThis()
            cell.delegate = self
            cell.contentType = .venue
            cell.collectionView.reloadData()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MixedShopsTableCell") as! MixedShopsTableCell
            cell.delegate = self
            cell.contentType = .venue
            if let venues = ExploreViewController.venues,
                self.finishedLoading {
                for i in 0 ..< cell.items.count {
                    let venue = venues[i + 3]
                    cell.titleLabels[i].text = venue.name
                    cell.subtitleLabels[i].text = venue.name
                    var imgs: [VenueImage?]? = nil
                    for images in ExploreViewController.venueImages {
                        if let venueId = images.first??.venueId,
                            venueId == venue.venueId {
                            imgs = images
                        }
                    }
                    
                    cell.items[i].id = venue.venueId
                    if let data = imgs?.first??.image {
                        cell.thumbnailImageViews[i].image = UIImage(data: data)
                    }
                }
            }
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClusteredShopsTableCell") as! ClusteredShopsTableCell
            cell.delegate = self
            cell.contentType = .venue
            if let venues = ExploreViewController.venues,
                self.finishedLoading {
                for i in 0 ..< cell.items.count {
                    let venue = venues[i + 3 + 3]
                    cell.titleLabels[i].text = venue.name
                    cell.subtitleLabels[i].text = venue.name
                    var imgs: [VenueImage?]? = nil
                    for images in ExploreViewController.venueImages {
                        if let venueId = images.first??.venueId,
                            venueId == venue.venueId {
                            imgs = images
                        }
                    }
                    
                    if let data = imgs?.first??.image {
                        cell.thumbnailImageViews[i].image = UIImage(data: data)
                    }
                    
                    cell.items[i].id = venue.venueId
                }
            }
            
            return cell
        default: return UITableViewCell()
        }
    }
    
    override func performSegue(id: String) {
        super.performSegue(id: id)
        self.performSegue(withIdentifier: "ShopDetails", sender: self)
    }
}
