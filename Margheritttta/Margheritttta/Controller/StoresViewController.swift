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
