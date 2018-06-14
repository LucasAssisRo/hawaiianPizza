//
//  StoresViewController.swift
//  Margheritttta
//
//  Created by Marco Romano on 02/05/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {
    var venueId: String!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var venueImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var productsStackView: UIStackView!
    @IBOutlet weak var productsLabel: UILabel!
    @IBOutlet var productImages: [UIImageView]!
    @IBOutlet weak var phoneImageView: UIImageView!
    @IBOutlet weak var phoneTextView: UITextView!
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var emailTextView: UITextView!
    @IBOutlet weak var reportButton: UIButton!

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
                var imgs: [VenueImage?]? = nil
                for images in ExploreViewController.venueImages {
                    if let venueId = images.first??.venueId,
                        venueId == venue.venueId {
                        imgs = images
                    }
                }
                
                if let data = imgs?.first??.image {
                    self.venueImageView.image = UIImage(data: data)
                }
                
                self.nameLabel.text = venue.name
                self.categoryLabel.text = venue.category.capitalized
                self.descriptionLabel.text = venue.description
                self.streetLabel.text = venue.address1
                self.cityLabel.text = venue.city
                
                if let phone = venue.phone {
                    self.phoneTextView.text = phone
                } else {
                    self.phoneTextView.isHidden = true
                }
                
                if let email = venue.email {
                    self.emailTextView.text = email
                } else {
                    self.emailTextView.isHidden = true
                }
                
                self.phoneImageView.image = self.phoneImageView.image?.withRenderingMode(.alwaysTemplate)
                self.phoneImageView.tintColor = UIColor.titleColor
                
                self.emailImageView.image = self.emailImageView.image?.withRenderingMode(.alwaysTemplate)
                self.emailImageView.tintColor = UIColor.titleColor
                
                self.productsStackView.isHidden = true
                self.productsLabel.isHidden = true
                self.productImages[0].isHidden = true
                self.productImages[1].isHidden = true
                self.productImages[2].isHidden = true
                self.reportButton.isHidden = true
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
        case self.productImages[0]:
            destination.myProd.images = "p1"
            destination.myProd.name = "First Product"
            destination.myProd.allergens = ["First allergen", "New allergen"]
            destination.myProd.description = "First Product Description"
            
            break
        case self.productImages[1]:
            destination.myProd.images = "p2"
            destination.myProd.name = "Second Product"
            destination.myProd.allergens = ["Second allergen", "New allergen"]
            destination.myProd.description = "Second Product Description"
            break
        case self.productImages[2]:
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
    
    @IBAction func expandDescription(_ sender: Any) {
        if self.descriptionLabel.numberOfLines == 1000 {
            self.descriptionLabel.numberOfLines = 5
            self.readMoreButton.setTitle(NSLocalizedString("show_more", comment: ""), for: .normal)
        } else {
            self.descriptionLabel.numberOfLines = 1000
            self.readMoreButton.setTitle(NSLocalizedString("show_less", comment: ""), for: .normal)
        }
    }
    
    @IBAction func btnReportAction(_ sender: UIButton) {
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

extension StoreViewController: SpringViewDelegate {
    func expand(to bounds: CGRect, with duration: TimeInterval) {
        UIView.animate(withDuration: TimeInterval(duration),
                       delay: 0,
                       options: [.layoutSubviews, .allowAnimatedContent, .curveEaseIn],
                       animations: {
                        self.scrollView.frame = bounds
        })
    }
    
    func colapse(to bounds: CGRect, with duration: TimeInterval) {
        self.scrollView.setContentOffset(.zero, animated: true)
        UIView.animate(withDuration: TimeInterval(duration),
                       delay: 0,
                       options: [.layoutSubviews, .allowAnimatedContent, .curveEaseIn],
                       animations: {
                        self.scrollView.frame = bounds
        })
    }
}

extension StoreViewController: UIScrollViewDelegate {
}
