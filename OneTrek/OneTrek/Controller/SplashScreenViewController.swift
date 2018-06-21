//
//  SplashScreenViewController.swift
//  OneTrek
//
//  Created by Lucas Assis Rodrigues on 20/06/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var icon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.icon.transform = self.icon.transform.rotated(by: 10 * .pi / 180)
        }) { finished in
            UIView.animate(withDuration: 0.2,
                           delay: 0,
                           options: [.repeat, .autoreverse, .curveLinear],
                           animations: {
                            self.icon.transform = self.icon.transform.rotated(by: -20 * .pi / 180)
            })
        }

        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
            self.performSegue(withIdentifier: "loaded", sender: self)
        }
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
