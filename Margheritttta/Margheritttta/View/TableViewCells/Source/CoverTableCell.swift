//
//  CoverTableCell.swift
//  Margheritttta
//
//  Created by Alexander Schülke on 19.05.18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import Foundation
import UIKit

class CoverTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    

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
        self.collectionView.register(CoverCollectionViewCell.self, forCellWithReuseIdentifier: "CoverCollectionViewCell")
        self.collectionView.register(UINib(nibName: "CoverCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CoverCollectionViewCell")
        
        collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameWidth = collectionView.frame.size.width
        return CGSize(width: frameWidth - 30, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoverCollectionViewCell", for: indexPath) as! CoverCollectionViewCell
        
        cell.contentView.layer.cornerRadius = 3
        cell.contentView.layer.masksToBounds = true

        return cell
    }
}

