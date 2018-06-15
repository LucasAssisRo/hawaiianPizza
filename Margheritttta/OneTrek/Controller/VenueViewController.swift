//
//  VenueViewController.swift
//  Margheritttta
//
//  Created by Lucas Assis Rodrigues on 15/06/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class VenueViewController: UIViewController {
    var venueId: String!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var venueImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var productsStackView: UIStackView!
    @IBOutlet weak var productsLabel: UILabel!
    @IBOutlet var productImages: [UIImageView]!
    @IBOutlet weak var phoneImageView: UIImageView!
    @IBOutlet weak var phoneTextView: UITextView!
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var emailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.phoneImageView.image = self.phoneImageView.image?.withRenderingMode(.alwaysTemplate)
        self.phoneImageView.tintColor = .black
        
        self.emailImageView.image = self.emailImageView.image?.withRenderingMode(.alwaysTemplate)
        self.emailImageView.tintColor = .black
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

extension VenueViewController: UIScrollViewDelegate { }
