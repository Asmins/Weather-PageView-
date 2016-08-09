//
//  SearchResultController.swift
//  Weather
//
//  Created by admin on 02.08.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import Foundation

protocol LocateOnMap {
    
    func locateWithLongitude(lon:Double, andLatitude lat:Double, andTitle title: String)
    
}

class SearchResultController: UITableViewController {
    
    var results: [String]!
    var delegate: LocateOnMap!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.results = Array()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"cellIdentifier")
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = self.results[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let meneger = CityManager()
        let address:String! = self.results[indexPath.row].stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.symbolCharacterSet())
        let url = NSURL(string: "https://maps.googleapis.com/maps/api/geocode/json?address=\(address)&sensor=false")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){ (data,response,error)->Void in
            do{
                if data != nil{
                    let data = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as! NSDictionary
                    if let results = data["results"] as? NSArray{
                        if let resultArray = results[0] as? NSDictionary{
                            
                            if let geometry = resultArray["geometry"] as? NSDictionary{
                                if let location = geometry["location"] as? NSDictionary{
                                    if let lat = location["lat"] as? Double{
                                        meneger.saveLat(lat)
                                    }
                                    if let lng = location["lng"] as? Double{
                                        meneger.saveLong(lng)
                                    }
                                }
                                if let adress_components = resultArray["address_components"] as? NSArray {
                                    if let cityName = adress_components[0] as? NSDictionary {
                                        if let long_name = cityName["long_name"] as? String{
                                            meneger.saveName(long_name)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    let lat = data["results"]?.valueForKey("geometry")?.valueForKey("location")?.valueForKey("lat")?.objectAtIndex(0) as! Double
                    let lon = data["results"]?.valueForKey("geometry")?.valueForKey("location")?.valueForKey("lng")?.objectAtIndex(0) as! Double
                    self.delegate.locateWithLongitude(lon, andLatitude: lat, andTitle: self.results[indexPath.row])
                }
            }
            catch{
                print("Error")
            }
        }
        task.resume()
    }
    
    func reloadData(array:[String]){
        self.results = array
        self.tableView.reloadData()
    }
}