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
        print("Fuck")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
