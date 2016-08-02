//
//  FirstViewController.swift
//  Weather
//
//  Created by admin on 01.08.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = true
        //navigationItem.hidesBackButton = true
        
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), forControlEvents: .TouchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().rearViewRevealWidth = 150
 }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showSetting(sender: AnyObject) {
        let settingMenu = UIAlertController(title: nil, message: "Setting", preferredStyle: .ActionSheet)
        
        let findMeToGPS = UIAlertAction(title: "Find Me (GPS)", style: UIAlertActionStyle.Default , handler: nil)
        
        let changeTo = UIAlertAction(title: "Change to F°", style: UIAlertActionStyle.Default, handler: nil)
        
        let cancel = UIAlertAction(title: "Exit", style: UIAlertActionStyle.Cancel, handler: nil)
        
        
        settingMenu.addAction(findMeToGPS)
        settingMenu.addAction(changeTo)
        settingMenu.addAction(cancel)
        
        self.presentViewController(settingMenu, animated: true, completion: nil)
        
    }
    @IBAction func showNowView(sender: AnyObject) {
        print("nOw")
    }
    
    @IBAction func showHourlyView(sender: AnyObject) {
        print("Hourly")
    }
    @IBAction func showDailyView(sender: AnyObject) {
        print("Daily")
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
