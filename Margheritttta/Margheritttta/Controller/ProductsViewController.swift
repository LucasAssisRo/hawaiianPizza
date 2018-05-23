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
    @IBOutlet weak var imgProductImage: UIImageView!
    
    //Product Title
    @IBOutlet weak var lblProductTitle: UILabel!
    
    //Product Allergens
    @IBOutlet weak var lblAllergens: UILabel!
    @IBOutlet weak var lblAllergensDescription: UILabel!
    
    //Product Description
    @IBOutlet weak var lblProductDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
