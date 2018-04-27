//
//  ViewController.swift
//  Margheritttta
//
//  Created by Lucas Assis Rodrigues on 23/04/2018.
//  Copyright © 2018 Lucas Assis Rodrigues. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let locString = NSLocalizedString("welcome", comment: "")
        lblLanguage.text = locString
        lbl2.text = "goodM".localized()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

