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
        self.collectionView.register(WideCollectionViewCell.self, forCellWithReuseIdentifier: "WideCollectionViewCell")
        self.collectionView.register(UINib(nibName: "WideCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WideCollectionViewCell")
        
        collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WideCollectionViewCell", for: indexPath) as! WideCollectionViewCell
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.selectItem(_:)))
        
        
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
}
