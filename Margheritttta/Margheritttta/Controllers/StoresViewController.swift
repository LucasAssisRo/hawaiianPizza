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
    
    // Header Informations
        // General Information
    @IBOutlet weak var labelShopType: UILabel!
    @IBOutlet weak var labelShopName: UILabel!
    @IBOutlet weak var labelStreetnameCity: UILabel!
    
        // Description
    
    @IBOutlet weak var labelShopDescription: UILabel!
    @IBOutlet weak var buttonMore: UIButton!
    @IBAction func buttonMoreAction(_ sender: UIButton) {
    }
    
    // Product images
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    
    @IBOutlet var imagesArray: [UIImageView]!
    
    // Contact
    
    // before the label maybe we need an image for the phone icon and the email icon
    @IBOutlet weak var labelContact: UILabel!
    @IBOutlet weak var labelMailContact: UILabel!
    
    // Report
    @IBOutlet weak var buttonReportThisShop: UIButton!
    @IBAction func buttonReportThisShopAction(_ sender: UIButton) {
    }
    
    //Class var
    var productToShow: String = ""
    var tapGestures = [UITapGestureRecognizer]()

    // this var is for internal test: it has to be replaced with the Venue struct
    var shop: Shop?
    
    struct Shop {
        var venueId: String
        var name: String
        var images: [String]
        var description: String
        var category: String
        var tags: [String]
        var address1: String
        var address2: String?
        var city: String
        var country: String
        var zipCode: String
        var phone: String?
        var email: String?
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        // this shop is for testing. It has to be replaced by the API.
        // change the number of the shop images to check if they are hidden or not
        shop = Shop(venueId: "venue1", name: "Tea Shop", images: ["p1","p2"], description: "The Best the you can drink...", category: "category1", tags: ["1", "2"], address1: "Via da the", address2: "address2", city: "Naples", country: "Italy", zipCode: "80100", phone: "+39.081.23.24.25", email: "thebest@thebest.com")
        
        
        
        // init the outlets
        labelShopType.text = shop?.category
        labelShopName.text = shop?.name
        labelStreetnameCity.text = "\(shop!.address1),\(shop!.city)"
        
        labelShopDescription.text = shop?.description

        // hide all images
        for img in imagesArray {
            img.isHidden = true
        }

        
        for i in 0 ... (shop?.images)!.count - 1 {
            imagesArray[i].isHidden = false
            imagesArray[i].image = UIImage(named: (shop?.images[i])!)
            imagesArray[i].isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            tapGestures.append(tap)
            tapGestures[i].name = "tapGest\(i)"
            imagesArray[i].addGestureRecognizer(tapGestures[i])
        }
        
        labelContact.text = shop?.phone
        labelMailContact.text = shop?.email
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer?) {
        // handling code
        switch sender?.name {
        case "tapGest0":
            productToShow = (shop?.images[0])!
        case "tapGest1":
            productToShow = (shop?.images[1])!
        case "tapGest2":
            productToShow = (shop?.images[2])!
        default:
            productToShow = ""
        }
        performSegue(withIdentifier: "shopSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "shopSegue" {
            let vc = segue.destination as! ProductsViewController
            vc.topImageName = productToShow
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print ("prepareForSegue")
//        if segue.identifier == "shopSegue" {
//            let vc = segue.destination as! ProductsViewController
//            self.present(vc, animated: true, completion: nil)
//        }
//    }
    
}
