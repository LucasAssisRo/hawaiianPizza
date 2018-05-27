//
//  ShopTableRow.swift
//  Margheritttta
//
//  Created by Alexander Schülke on 19.05.18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit
import KituraKit

class LinearShopsTableCell: GenericTableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func registerNibThis() {
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(LinearCollectionViewCell.self, forCellWithReuseIdentifier: "LinearCollectionViewCell")
        self.collectionView.register(UINib(nibName: "LinearCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LinearCollectionViewCell")
        
        ServerHandler.shared.getAllVenues { venues, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let venues = venues else {
                print(RequestError.badRequest)
                return
            }
            
            self.venues = venues
            self.venueImages.removeAll()
            for venue in venues {
                ServerHandler.shared.getVenueImages(by: venue.venueId, completion: { images, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    guard let images = images else {
                        print(RequestError.badRequest)
                        return
                    }
                    
                    print(self.venueImages.count)
                    DispatchQueue.main.sync {
                        self.venueImages.append(images)
                        self.collectionView.reloadData()
                    }
                })
            }
        }
        
        collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let venues = venues else {
            print("didnt load")
            return 5
        }
        
        return venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LinearCollectionViewCell", for: indexPath) as! LinearCollectionViewCell
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.selectItem(_:)))
        cell.item.addGestureRecognizer(tap)
        cell.item.delegate = self
        cell.titleLabel.text = self.venues?[indexPath.row].name
        cell.subtitleLabel.text = self.venues?[indexPath.row].category
        if indexPath.row < self.venueImages.count,
            let data = self.venueImages[indexPath.row]?.first?.image {
            cell.thumbnailImageView.image = UIImage(data: data)
        }
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor(red: 229/255, green: 234/255, blue: 240/255, alpha: 146/255).cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 8.0)
        cell.layer.shadowRadius = 8.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
}
