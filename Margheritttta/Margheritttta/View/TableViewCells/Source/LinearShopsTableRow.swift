//
//  ShopTableRow.swift
//  Margheritttta
//
//  Created by Alexander Schülke on 19.05.18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit
import KituraKit

class LinearShopsTableRow: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var venues: [Venue]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func registerNibThis() {
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(ShopCollectionViewItem.self, forCellWithReuseIdentifier: "ShopCollectionViewItem")
        self.collectionView.register(UINib(nibName: "ShopCollectionViewItem", bundle: nil), forCellWithReuseIdentifier: "ShopCollectionViewItem")
        
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
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
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
            return 0
        }
        
        return venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let venue = venues?[indexPath.row] else {
            print("didnt load")
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCollectionViewItem", for: indexPath) as! ShopCollectionViewItem
        cell.thumbnailImageView.image = venue.imagesDecoded?.first
        print(venue.name, venue.imagesDecoded?.first)
        cell.shopName.text = venue.name
        cell.categoryLabel.text = venue.category
        
        cell.contentView.layer.cornerRadius = 3
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        cell.layer.shadowOffset = CGSize(width:2,height: 4.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
}
