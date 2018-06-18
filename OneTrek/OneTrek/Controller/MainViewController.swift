//
//  MainViewController.swift
//  Margheritttta
//
//  Created by Lucas Assis Rodrigues on 14/06/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
//        guard let storyboard = self.storyboard else { return }
//        self.springView.didMoveToSuperview()
//        let embededViewController = storyboard.instantiateViewController(withIdentifier: "shop") as! VenueViewController
//        self.springView.embed(viewController: embededViewController, in: self, delegate: embededViewController)
//        self.springView.indexSubviews(self.view)
        NotificationCenter.default.addObserver(self, selector: #selector(disableScrolling(_:)), name: NSNotification.Name.springExpand, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enableScrolling(_:)), name: NSNotification.Name.springColapse, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setStatusBarHidden(_ isHidden: Bool, with duration: TimeInterval) {
        self._isStatusBarHidden = isHidden
        UIView.animate(withDuration: duration) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    @objc func disableScrolling(_ notification: NSNotification) {
        self.scrollView.isScrollEnabled = false
        self.setStatusBarHidden(true, with: 0.1)
    }
    
    @objc func enableScrolling(_ notification: NSNotification) {
        self.scrollView.isScrollEnabled = true
        self.setStatusBarHidden(false, with: 0.1)
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
    }
}
