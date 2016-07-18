//
//  HourlyViewController.swift
//  Weather
//
//  Created by admin on 18.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit

class HourlyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var weather = [Weather]()
    
    let url = "https://api.wunderground.com/api/4ed7dad052717db4/hourly/q/CA/Los_Angeles.json"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromJson()

        // Do any additional setup after loading the view.
    }

    func getDataFromJson(){
        let request = NSURLRequest(URL: NSURL(string: url)!)
        let urlSesion = NSURLSession.sharedSession()
        
        let task = urlSesion.dataTaskWithRequest(request, completionHandler: {(data,respone,error) -> Void in
            if let error = error{
                print(error)
                return
            }
            if let data = data{
                self.weather = self.parseJsonData(data)
            
                NSOperationQueue.mainQueue().addOperationWithBlock({()-> Void in
                    self.tableView.reloadData()
                })
                
            }
            
            
        })
        
            task.resume()
        
    }
    
        
        
        func parseJsonData(data:NSData) -> [Weather]{
            do{
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                if let root = jsonResult!["hourly_forecast"] as? NSArray{
                    for data in root{
                        
                        let dataAboutWeather = Weather()
                        
                        
                        if let time = data["FCTTIME"] as? NSDictionary{
                            dataAboutWeather.hour = time["hour"] as! String
                        }
                        if let temp = data["temp"] as? NSDictionary{
                            dataAboutWeather.temperature = temp["metric"] as! String
                        }
                        dataAboutWeather.humidity = data["humidity"] as! String
                        dataAboutWeather.typeWeather = data["condition"] as! String
                        weather.append(dataAboutWeather)
                    }
                    
                    weather[0...9] = []
                }
            }catch{
                print(error)
            }
            return weather
        }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomTableViewCell
        cell.labelForHour.text = "\(weather[indexPath.row].hour):00"
        cell.labelForTemperature.text = "\(weather[indexPath.row].temperature)°"
        cell.labelForTypeWeather.text = weather[indexPath.row].typeWeather
        return cell
    }
    
    
}
