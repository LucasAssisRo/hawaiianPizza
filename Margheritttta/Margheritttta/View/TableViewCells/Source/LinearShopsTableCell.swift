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
    private var venues: [Venue]?
    private var venueImages: [[VenueImage]?] = []
    
    private var loaded = false
    private var isSkeletonHighlighted = false
    var timer: Timer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.comminInit()
    }
    
    func registerNibThis() {
        print("not loaded yet")
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(LinearCollectionViewCell.self, forCellWithReuseIdentifier: "LinearCollectionViewCell")
        self.collectionView.register(UINib(nibName: "LinearCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LinearCollectionViewCell")
        self.collectionView.register(SkeletonCollectionViewCell.self, forCellWithReuseIdentifier: "SkeletonCollectionViewCell")
        self.collectionView.register(UINib(nibName: "SkeletonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SkeletonCollectionViewCell")
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
                    
                    self.venueImages.append(images)
                    DispatchQueue.main.sync {
                        self.collectionView.reloadData()
                    }
                })
            }
            
            DispatchQueue.main.sync {
                self.loaded = true
                print("loaded")
                self.collectionView.reloadData()
            }
        }

        collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.comminInit()
    }
    
    func comminInit() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.animateSkeletons), userInfo: nil, repeats: false)
    }
    
    @objc private func animateSkeletons() {
        var sortedCells = collectionView.visibleCells
        sortedCells.sort {
            if let itemIndex = collectionView.indexPath(for: $0)?.item, let secondItemIndex = collectionView.indexPath(for: $1)?.item {
                return itemIndex < secondItemIndex
            }
            return true
        }
        print(sortedCells)
        for (index, cell) in sortedCells.enumerated() {
            let skeletonCell = cell as! SkeletonCollectionViewCell

            UIView.animate(withDuration: TimeInterval(index), delay: 0, options: [], animations: {
//                    print(index)
                self.highlightSkeletonCell(skeletonCell, totalItems: sortedCells.count, firstCall: true)
//                    skeletonCell.image.layer.backgroundColor = GlobalConstantss.skeletonHighlighted
                })
        }
    }
    
    private func highlightSkeletonCell(_ cell: SkeletonCollectionViewCell, totalItems: Int, firstCall: Bool) {
        let delay = firstCall ? 0 : totalItems
        UIView.animate(withDuration: 1, delay: Double(delay/2), animations: {
            cell.image.layer.backgroundColor = GlobalConstantss.skeletonHighlighted
            cell.title.layer.backgroundColor = GlobalConstantss.skeletonHighlighted
            cell.subtitle.layer.backgroundColor = GlobalConstantss.skeletonHighlighted
            cell.tag = 1
        }, completion: { finish in
            self.unhighlightSkeletonCell(cell, totalItems: totalItems)
        })
    }
    
    private func unhighlightSkeletonCell(_ cell: SkeletonCollectionViewCell, totalItems: Int) {
        UIView.animate(withDuration: 0.4, delay: Double(0), animations: {
            cell.image.layer.backgroundColor = GlobalConstantss.skeletionUnhighlighted
            cell.title.layer.backgroundColor = GlobalConstantss.skeletionUnhighlighted
            cell.subtitle.layer.backgroundColor = GlobalConstantss.skeletionUnhighlighted
            cell.tag = 0
        }, completion: { finish in
            self.highlightSkeletonCell(cell, totalItems: totalItems, firstCall: false)
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let venues = venues else {
            return 3
        }
        
        return venues.count
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
<<<<<<< HEAD
        if self.loaded {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LinearCollectionViewCell", for: indexPath) as! LinearCollectionViewCell
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.selectItem(_:)))
            cell.item.addGestureRecognizer(tap)
            cell.item.delegate = self
            
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
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkeletonCollectionViewCell", for: indexPath) as! SkeletonCollectionViewCell
            
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
}
