//
//  FirstViewController.swift
//  Weather
//
//  Created by admin on 01.08.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var labelForNameCity: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    
    var manager = CityManager()
    var locationManager:CLLocationManager!
    
    var location: CLLocation!{
        didSet{
            manager.saveLat(location.coordinate.latitude)
            manager.saveLong(location.coordinate.longitude)
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            print("This coordinates from gps")
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        navigationController?.navigationBarHidden = true
        labelForNameCity.text = "\(manager.getName())"
        
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().rearViewRevealWidth = 200
        
    }
    
    
    func checkCoreLocation(){
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse{
            locationManager.startUpdatingHeading()
        }else if CLLocationManager.authorizationStatus() == .NotDetermined{
            locationManager.requestWhenInUseAuthorization()
        }else if CLLocationManager.authorizationStatus() == .Restricted{
            print("Use location service")
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
        locationManager.stopUpdatingLocation()
    }
    
    
   
    @IBAction func showSetting(sender: AnyObject) {
        let settingMenu = UIAlertController(title: nil, message: "Setting", preferredStyle: .ActionSheet)
        
        let findMeToGPS = UIAlertAction(title: "Find Me (GPS)", style: UIAlertActionStyle.Default , handler: {(action)-> Void in
           self.locationManager.startUpdatingLocation()
        })
        
        let changeTo = UIAlertAction(title: "Change to F°", style: UIAlertActionStyle.Default, handler: nil)
        
        let cancel = UIAlertAction(title: "Exit", style: UIAlertActionStyle.Cancel, handler: nil)
        
        
        settingMenu.addAction(findMeToGPS)
        settingMenu.addAction(changeTo)
        settingMenu.addAction(cancel)
        
        self.presentViewController(settingMenu, animated: true, completion: nil)
        
    }
    
    @IBAction func showNowView(sender: AnyObject) {
        
    }
    
    @IBAction func showHourlyView(sender: AnyObject) {
        
    }
    @IBAction func showDailyView(sender: AnyObject) {
        
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
