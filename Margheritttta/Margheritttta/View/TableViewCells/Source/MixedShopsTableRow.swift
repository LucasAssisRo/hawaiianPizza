//
//  WideShopsTableRow.swift
//  Margheritttta
//
//  Created by Alexander Schülke on 21.05.18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import Foundation
import UIKit

class MixedShopsTableRow: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    func registerNibThis() {
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(MixedCollectionViewItem.self, forCellWithReuseIdentifier: "MixedCollectionViewItem")
        self.collectionView.register(UINib(nibName: "MixedCollectionViewItem", bundle: nil), forCellWithReuseIdentifier: "MixedCollectionViewItem")
        
        collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameWidth = collectionView.frame.size.width
        return CGSize(width: frameWidth - 30, height: 400)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MixedCollectionViewItem", for: indexPath) as! MixedCollectionViewItem
        
//        cell.contentView.layer.cornerRadius = 3
//        cell.contentView.layer.masksToBounds = true
//        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
//        cell.layer.shadowOffset = CGSize(width:2,height: 4.0)
//        cell.layer.shadowRadius = 4.0
//        cell.layer.shadowOpacity = 1.0
//        cell.layer.masksToBounds = false;
//        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
}
