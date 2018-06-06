//
//  TourViewController.swift
//  Margheritttta
//
//  Created by Alexander Schülke on 06.06.18.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class TourViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var tourDescription: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var milestonesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(TourShopCollectionViewCell.self, forCellWithReuseIdentifier: "TourShopCollectionViewCell")
        self.collectionView.register(UINib(nibName: "TourShopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TourShopCollectionViewCell")
   
        self.view.addSubview(self.collectionView)
        self.collectionView.topAnchor.constraint(equalTo: milestonesLabel.bottomAnchor, constant: 30).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        self.collectionView.heightAnchor.constraint(equalToConstant: 190).isActive = true
//        self.collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TourShopCollectionViewCell", for: indexPath) as! TourShopCollectionViewCell
        
        cell.shopnameLabel.text = "Exquisiment"
        cell.layer.cornerRadius = CGFloat(GlobalConstantss.cornerRadius)
        cell.layer.masksToBounds = true
        
        cell.layer.shadowColor = GlobalConstantss.shadowColor
        cell.layer.shadowOffset = GlobalConstantss.shadowOffset
        cell.layer.shadowRadius = CGFloat(GlobalConstantss.shadowradius)
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.layer.cornerRadius).cgPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 30, height: 50)
    }

}
