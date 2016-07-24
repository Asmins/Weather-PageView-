//
//  MoreDetailViewController.swift
//  Weather
//
//  Created by admin on 24.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit

class MoreDetailViewController: UIViewController {

    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
