//
//  TourTableViewController.swift
//  OneTrek
//
//  Created by Lucas Assis Rodrigues on 15/06/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class TourTableViewController: UITableViewController {
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
    
    var isPresenting: Bool = false {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.registerNibs()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(expand(_:)),
                                               name: .springExpand,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(colapse(_:)),
                                               name: .springColapse,
                                               object: nil)
    }
    
    private func registerNibs() {
        self.tableView.register(SpringTableViewCell.self,
                                forCellReuseIdentifier: "spring")
        self.tableView.register(UINib(nibName: "SpringTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "spring")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.isPresenting ? self.view.bounds.height : 391
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let storyboard = self.storyboard else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "spring") as! SpringTableViewCell
        cell.springView.didMoveToSuperview()
        let embededViewController = storyboard.instantiateViewController(withIdentifier: "shop") as! VenueViewController
        cell.springView.embed(viewController: embededViewController, in: self, delegate: embededViewController)
        cell.springView.indexSubviews(self.view)
        cell.sizeToFit()
        return cell
    }
 
    func setStatusBarHidden(_ isHidden: Bool, with duration: TimeInterval) {
        self._isStatusBarHidden = isHidden
        UIView.animate(withDuration: duration) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    @objc func expand(_ notification: NSNotification) {
            self.isPresenting = true
    }
    
    @objc func colapse(_ notification: NSNotification) {
        self.isPresenting = false
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
