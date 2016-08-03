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
            self.getNameCity(Float(location.coordinate.latitude), long: Float(location.coordinate.longitude))
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
        view.reloadInputViews()
        
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
        
        let changeTo = UIAlertAction(title: "Change to F°/C°", style: UIAlertActionStyle.Default, handler: {(action)-> Void in
            
        })
        
        let cancel = UIAlertAction(title: "Exit", style: UIAlertActionStyle.Cancel, handler: nil)
        
        
        settingMenu.addAction(findMeToGPS)
        settingMenu.addAction(changeTo)
        settingMenu.addAction(cancel)
        
        self.presentViewController(settingMenu, animated: true, completion: nil)
        
    }
    
    func getNameCity(lat:Float,long:Float){
        let url = NSURL(string: "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(lat),\(long)&sensor=false")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){(data,response,error)-> Void in
            do{
                if data != nil{
                    let data = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as! NSDictionary
                    if let result = data["results"] as? NSArray{
                        if let resultArray = result[0] as? NSDictionary{
                            if let adress = resultArray["address_components"] as? NSArray{
                                if let number = adress[2] as? NSDictionary{
                                    if let name = number["long_name"] as? String{
                                        self.manager.saveName(name)
                                        self.labelForNameCity.text = "\(name)"
                                    }
                                }
                            }
                        }
                    }
                    
                }
                
            }catch{
                print("Error")
            }
        }
        task.resume()

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
