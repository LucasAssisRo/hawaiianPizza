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
    
    
    //Class var
    
    //fake shop struct for testing
    struct MyShop {
         var images: [String]
         var tags: [String]
         var venueId: String
         var name: String
         var description: String
         var category: String
         var address1: String
         var address2: String?
         var city: String
         var country: String
         var zipCode: String
         var phone: String?
         var email: String?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide all product images
        for img in imgProducts {
            img.isHidden = true
        }
        
        let myShop = MyShop(images: ["p1", "p2", "p3"], tags: ["tag1", "tag2"], venueId: "VenueId", name: "Tea Shop", description: "The best tea shop", category: "Vegan", address1: "Via da the", address2: "Vomero", city: "Naples", country: "Italy", zipCode: "80100", phone: "+39.081.234.567.89", email: "thebest@thebest.com")
        
        imgTopTitleImage.image = UIImage(named: "2")
        lblShopName.text = myShop.name
        lblShopType.text = myShop.category
        lblShopDescription.text = myShop.description
        lblShopStreetnameCity.text = "\(myShop.address1), \(myShop.city)"
        
        //load the right number of images
        for i in 0...myShop.images.count - 1 {
            imgProducts[i].isHidden = false
            imgProducts[i].image = UIImage(named: myShop.images[i])
            imgProducts[i].isUserInteractionEnabled = true
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
