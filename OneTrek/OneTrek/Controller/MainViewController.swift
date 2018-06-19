//
//  MainViewController.swift
//  Margheritttta
//
//  Created by Lucas Assis Rodrigues on 14/06/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

@IBDesignable
class MainViewController: UIViewController {
    
    @IBOutlet weak var marginView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    var venues: [Venue?] = [
        Venue(venueId: "0",
              name: "Il Musicante",
              description:
"""
Il Musicante is the perfect place where to find any kind of rare vinyl from pop to classic music. Of course this is just the place to be if you want to discover some Neapolitan traditional music gems, like Roberto De Simone original records and iconic Neapolitan movies.
""",
              category: "Vintage Store",
              address1: "idk the address",
              address2: "idk the address",
              city: "Naples",
              country: "Italy",
              zipCode: "idk the address",
              phone: "idk the phone",
              email: "idk the email")
    ]
    
    @IBInspectable var hasLightStatusBar: Bool = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.hasLightStatusBar ? .lightContent : .default
    }
    
    private var _isStatusBarHidden: Bool = false
    
    var isStatusBarHidden: Bool {
        get {
            return self._isStatusBarHidden
        }
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return self._isStatusBarHidden
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let storyboard = self.storyboard else { return }
        for view in self.stackView.arrangedSubviews {
            if let springView = view as? SpringView {
                springView.didMoveToSuperview()
                let embededViewController = storyboard.instantiateViewController(withIdentifier: "shop") as! VenueViewController
                embededViewController.venue = self.venues[0]
                springView.embed(viewController: embededViewController, in: self, delegate: embededViewController)
                springView.indexSubviews(self.view)
            }
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(disableScrolling(_:)),
                                               name: NSNotification.Name.springExpand,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(enableScrolling(_:)),
                                               name: NSNotification.Name.springColapse,
                                               object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1,
                       delay: 0.5,
                       options: .curveEaseOut,
                       animations: {
                        self.filterView.alpha = 0.3
                        self.scrollView.contentOffset = CGPoint(x: 0, y: self.marginView.bounds.height + 20)
        }) { finished in
            self.scrollView.contentOffset = .zero
            self.marginView.isHidden = true
            for view in self.stackView.arrangedSubviews {
                if let springView = view as? SpringView {
                    springView.smallFrame.origin.y -= self.marginView.bounds.height
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setStatusBarHidden(_ isHidden: Bool, with duration: TimeInterval) {
        self._isStatusBarHidden = isHidden
        UIView.animate(withDuration: duration) {
            self.setNeedsStatusBarAppearanceUpdate()
            self.scrollView.frame.origin.y -= self._isStatusBarHidden ? 20 : -20
            self.scrollView.frame.size.height += self._isStatusBarHidden ? 20 : -20
        }
    }
    
    @objc func disableScrolling(_ notification: NSNotification) {
        self.scrollView.isScrollEnabled = false
        if let info = notification.userInfo,
            let animated = info["animated"] as? Bool,
            let duration = info["duration"] as? CGFloat {
            self.setStatusBarHidden(animated, with: TimeInterval(duration))
        }
    }
    
    @objc func enableScrolling(_ notification: NSNotification) {
        self.scrollView.isScrollEnabled = true
        if let info = notification.userInfo,
            let animated = info["animated"] as? Bool,
            let duration = info["duration"] as? CGFloat {
            self.setStatusBarHidden(animated, with: TimeInterval(duration))
        }
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

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SpringView.offset = scrollView.contentOffset
        SpringView.offset.y -= 8
        
        for subview in self.stackView.arrangedSubviews {
            if let springview = subview as? SpringView {
                UIView.animate(withDuration: 0.1,
                               delay: 0,
                               options: [.layoutSubviews, .allowAnimatedContent, .curveEaseOut],
                               animations: {
                                springview.transform = .identity
                })
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
  
    }
}
