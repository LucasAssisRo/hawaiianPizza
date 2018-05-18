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
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    
    var imageSender : Int = 0
    var productToShow: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let tapFirst = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapFirst.name = "tapFirst"
        firstImage.isUserInteractionEnabled = true
        firstImage.addGestureRecognizer(tapFirst)
      
        let tapSecond = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapSecond.name = "tapSecond"
        secondImage.isUserInteractionEnabled = true
        secondImage.addGestureRecognizer(tapSecond)
        
        let tapThird = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapThird.name = "tapThird"
        thirdImage.isUserInteractionEnabled = true
        thirdImage.addGestureRecognizer(tapThird)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer?) {
        // handling code
        switch sender?.name {
        case "tapFirst":
            productToShow = "1"
        case "tapSecond":
            productToShow = "2"
        case "tapThird":
            productToShow = "3"
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
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
        
        
        super.performSegue(withIdentifier: identifier, sender: sender)
    }
    

}
