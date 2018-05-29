//
//  StoresViewController.swift
//  Margheritttta
//
//  Created by Marco Romano on 02/05/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class StoresViewController: UIViewController {
    
    // Outlets
    var venueId: String!
    
    //Top
    @IBOutlet weak var imgTopTitleImage: UIImageView!
    
    //Header info - general
    @IBOutlet weak var lblShopType: UILabel!
    @IBOutlet weak var lblShopName: UILabel!
    @IBOutlet weak var lblShopStreetnameCity: UILabel!
    
    //Header info - description
    
    @IBOutlet weak var lblShopDescription: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    @IBAction func btnMoreAction(_ sender: UIButton) {
    }
    
    //Products - header
    @IBOutlet weak var lblProducts: UILabel!
    
    //Products - images
    @IBOutlet var imgProducts: [UIImageView]!
    
    //Button Report this shop
    @IBOutlet weak var btnReport: UIButton!
    @IBAction func btnReportAction(_ sender: UIButton) {
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let venues = ExploreViewController.venues {
            var venue: Venue? = nil
            for v in venues {
                if v.venueId == self.venueId {
                    venue = v
                    break
                }
            }
            
            if let venue = venue {
                self.lblShopName.text = venue.name
                self.lblShopType.text = venue.category
                self.lblShopDescription.text = venue.description
                self.lblShopStreetnameCity.text = "\(venue.address1), \(venue.address2 ?? ""), \(venue.city)"
                var imgs: [VenueImage?]? = nil
                for images in ExploreViewController.venueImages {
                    if let venueId = images.first??.venueId,
                        venueId == venue.venueId {
                        imgs = images
                    }
                }
                
                if let data = imgs?.first??.image {
                    self.imgTopTitleImage.image = UIImage(data: data)
                }
            } else {
               // ERROR VIEW
            }
        } else {
            // ERROR VIEW
        }
    }
    
    @IBAction func displayProduct(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "productsViewController") as! ProductsViewController
        
        guard let view = sender.view else { return }
        switch view {
        case self.imgProducts[0]:
            destination.myProd.images = "p1"
            destination.myProd.name = "First Product"
            destination.myProd.allergens = ["First allergen", "New allergen"]
            destination.myProd.description = "First Product Description"

            break
        case self.imgProducts[1]:
            destination.myProd.images = "p2"
            destination.myProd.name = "Second Product"
            destination.myProd.allergens = ["Second allergen", "New allergen"]
            destination.myProd.description = "Second Product Description"
            break
        case self.imgProducts[2]:
            destination.myProd.images = "p3"
            destination.myProd.name = "Third Product"
            destination.myProd.allergens = ["First allergen", "New allergen"]
            destination.myProd.description = "Firs Product Description"
            break
        default:
            return
        }
        
        self.present(destination, animated: true)
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
