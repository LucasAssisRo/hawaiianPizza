//
//  MainViewController.swift
//  Margheritttta
//
//  Created by Marco Romano on 27/04/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
 
    @IBOutlet weak var collectionViewNear: UICollectionView!
    
    let imagesTopFt: [String] = ["2", "2", "2", "2", "2"]

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewNear.delegate = self
        collectionViewNear.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionViewNear {
            return imagesTopFt.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case collectionViewNear:
            let cell0 = collectionView.dequeueReusableCell(withReuseIdentifier: "CellShopsNear", for: indexPath) as! CellNearShops
            
            cell0.imageViewShopNear.image = UIImage(named: imagesTopFt[indexPath.row])
            return cell0
        default:
            break
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: "CellShopsNear", for: indexPath)
        
    }
    
    
}
