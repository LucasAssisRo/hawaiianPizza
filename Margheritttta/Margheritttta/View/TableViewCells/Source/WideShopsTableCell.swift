//
//  WideShopsTableCell.swift
//  Margheritttta
//
//  Created by Alexander Schülke on 21.05.18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import Foundation
import UIKit

class WideShopsTableCell: GenericTableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var loaded = true
    var timer: Timer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.comminInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.comminInit()
    }
    
    func comminInit() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.animateSkeletons), userInfo: nil, repeats: false)
    }
    
    @objc private func animateSkeletons() {
        if !self.loaded {
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
                    self.highlightSkeletonCell(skeletonCell, totalItems: sortedCells.count, firstCall: true)
                })
            }
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
    
    func registerNibThis() {
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(WideCollectionViewCell.self, forCellWithReuseIdentifier: "WideCollectionViewCell")
        self.collectionView.register(UINib(nibName: "WideCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WideCollectionViewCell")
        self.collectionView.register(WideSkeletonCollectionViewCell.self, forCellWithReuseIdentifier: "WideSkeletonCollectionViewCell")
        self.collectionView.register(UINib(nibName: "WideSkeletonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WideSkeletonCollectionViewCell")
        
        collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.contentType {
        case .venue:
            guard let _ = ExploreViewController.venues else { return 0 }
            return 3
        case .tour:
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        if self.loaded {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WideCollectionViewCell", for: indexPath) as! WideCollectionViewCell
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.selectItem(_:)))
        switch self.contentType {
        case .venue:
            if let venue = ExploreViewController.venues?[indexPath.row] {
                cell.subtitleLabel.text = venue.name
                cell.titleLabel.text = venue.category
                if let data = self.findImages(by: venue.venueId).first??.image {
                    cell.thumbnailImageView.image = UIImage(data: data)
                }
                
            }
        case .tour: break
        }
        
        
        cell.item.addGestureRecognizer(tap)
        cell.item.delegate = self
        cell.contentView.layer.cornerRadius = CGFloat(GlobalConstantss.cornerRadius)
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = GlobalConstantss.shadowColor
        cell.layer.shadowOffset = GlobalConstantss.shadowOffset
        cell.layer.shadowRadius = CGFloat(GlobalConstantss.shadowradius)
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
    //        else {
    //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WideSkeletonCollectionViewCell", for: indexPath) as! WideSkeletonCollectionViewCell
    //
    //            cell.contentView.layer.cornerRadius = 10
    //            cell.contentView.layer.masksToBounds = true
    //            cell.layer.shadowColor = UIColor(red: 229/255, green: 234/255, blue: 240/255, alpha: 146/255).cgColor
    //            cell.layer.shadowOffset = CGSize(width:0,height: 8.0)
    //            cell.layer.shadowRadius = 8.0
    //            cell.layer.shadowOpacity = 1.0
    //            cell.layer.masksToBounds = false;
    //            cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
    //
    //            return cell
    //        }
}
