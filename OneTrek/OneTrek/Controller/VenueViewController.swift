//
//  VenueViewController.swift
//  Margheritttta
//
//  Created by Lucas Assis Rodrigues on 15/06/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class VenueViewController: UIViewController {
    var springView: SpringView!
    var venue: Venue!
    var venueImage: UIImage? = nil
    var products: [Product] = []
    var productImages: [UIImage] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var venueImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var promotionalLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var productsStackView: UIStackView!
    @IBOutlet weak var productsLabel: UILabel!
    @IBOutlet var productImageViews: [UIImageView]!
    @IBOutlet var productTitleLabels: [UILabel]!
    @IBOutlet weak var addressTextView: UITextViewFixed!
    @IBOutlet weak var phoneStackView: UIStackView!
    @IBOutlet weak var phoneImageView: UIImageView!
    @IBOutlet weak var phoneTextView: UITextView!
    @IBOutlet weak var emailStackView: UIStackView!
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var emailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.descriptionLabel.isHidden = true

        self.phoneImageView.image = self.phoneImageView.image?.withRenderingMode(.alwaysTemplate)
        self.phoneImageView.tintColor = .black
        
        self.emailImageView.image = self.emailImageView.image?.withRenderingMode(.alwaysTemplate)
        self.emailImageView.tintColor = .black
        
        self.productsLabel.isHidden = true
        
        self.productImageViews.sort { first, second -> Bool in
            return first.tag < second.tag
        }
        
        self.productTitleLabels.sort { first, second -> Bool in
            return first.tag < second.tag
        }
        
        if let venue = self.venue {
            self.venueImageView.image = self.venueImage
            self.nameLabel.text = venue.name
            self.categoryLabel.text = venue.category
            self.promotionalLabel.text = venue.promotional
            self.descriptionLabel.text = venue.description
            if let address2 = venue.address2 {
                self.addressTextView.text =
                """
                \(venue.address1)
                \(address2), \(venue.zipCode)
                \(venue.city), \(venue.country)
                """
            } else {
                self.addressTextView.text =
                """
                \(venue.address1), \(venue.zipCode)
                \(venue.city), \(venue.country)
                """
            }
            
            if let phone = venue.phone {
                self.phoneTextView.text = phone
            } else {
                self.phoneStackView.isHidden = true
            }
            
            if let email = venue.email {
                self.emailTextView.text = email
            } else {
                self.emailStackView.isHidden = true
            }
            
            if self.products.count > 0 {
                for (i, product) in self.products.enumerated() {
                    if i < self.products.count {
                        self.productTitleLabels[i].text = product.name
                        self.productImageViews[i].image = self.productImages[i]
                    } else {
                        self.productTitleLabels[i].isHidden = true
                        self.productImageViews[i].isHidden = true
                    }
                }
            } else {
                self.productsStackView.isHidden = true
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func expandDescription(_ sender: Any) {
        if !self.descriptionLabel.isHidden {
            self.descriptionLabel.isHidden = true
            self.readMoreButton.setTitle(NSLocalizedString("show_more", comment: ""), for: .normal)
        } else {
            self.descriptionLabel.isHidden = false            
            self.readMoreButton.setTitle(NSLocalizedString("show_less", comment: ""), for: .normal)
        }
    }
}

extension VenueViewController: SpringViewDelegate {
    func expand(to bounds: CGRect, animated: Bool, with duration: TimeInterval) {
        if let parent = self.parent as? MainViewController {
            parent.setStatusBarHidden(true, with: duration)
        }
        
        UIView.animate(withDuration: !animated ? 0 : TimeInterval(duration),
                       delay: 0,
                       options: [.layoutSubviews, .allowAnimatedContent, .curveEaseIn],
                       animations: {
                        self.scrollView.frame = bounds
        })
    }
    
    func colapse(to bounds: CGRect, animated: Bool, with duration: TimeInterval) {
        self.scrollView.setContentOffset(.zero, animated: animated)
        if let parent = self.parent as? MainViewController {
            parent.setStatusBarHidden(false, with: duration)
        }

        UIView.animate(withDuration: !animated ? 0 : TimeInterval(duration),
                       delay: 0,
                       options: [.layoutSubviews, .allowAnimatedContent, .curveEaseIn],
                       animations: {
                        self.scrollView.frame = bounds
        })
    }
}

extension VenueViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if y <= 0 {
            let scale = y / 1000 // this should be a negative value
            self.springView.transform = CGAffineTransform(scaleX: 1 + scale, y: 1 + scale)
            if scale <= -0.15 {
                let frame = self.springView.frame
                self.springView.transform = .identity
                self.springView.frame = frame
                self.springView.colapseView(self, animated: true)
            }
        }
    }
}

@IBDesignable class UITextViewFixed: UITextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setup()
    }
    
    func setup() {
        self.textContainerInset = .zero
        self.textContainer.lineFragmentPadding = 0
    }
}
