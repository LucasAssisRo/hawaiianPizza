//
//  ProductsViewController.swift
//  Margheritttta
//
//  Created by Marco Romano on 02/05/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

    //Outlets
    
    //Product image
    @IBOutlet weak var topImage: UIImageView!
   
    //Product name
    @IBOutlet weak var labelProductTitle: UILabel!
    
    //Details type (like allergenes)
    @IBOutlet weak var labelDetailTitle: UILabel!
    
    //Details content
    @IBOutlet weak var labelDetailContent: UILabel!
    
    //Product description
    @IBOutlet weak var labelProductDescription: UILabel!
    
    //Class var
    var topImageName: String = ""
    

    // var used for testing: here we'll use the API
        var name: String = ""
        var images: String = ""
        var allergens: [String] = []
        var productDescription: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        var textAllergens = ""
        
        topImage.image = UIImage(named: topImageName)
        labelProductTitle.text = name
        labelDetailContent.text = "Allergens"
        labelProductDescription.text = productDescription
        for i in 0...(allergens.count) - 2 {
            textAllergens += "\(allergens[i]), "
        }
        textAllergens += (allergens.last)!
        labelDetailContent.text = textAllergens
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
