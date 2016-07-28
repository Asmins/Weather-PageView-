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
    
    let url = "http://api.wunderground.com/api/4ed7dad052717db4/hourly/q/49.51,30.48.json"
    
    var weather = [WeatherHourly]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getWeather()
    }

        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomTableViewCell
        cell.labelForHour.text = "\(weather[indexPath.row].hour):00"
        cell.labelForTypeWeather.text = "\(weather[indexPath.row].typeWeather)"
        cell.labelForTemperature.text = "\(weather[indexPath.row].temperature)°"
        return cell
    }
    
    func getWeather(){
        let reques = NSURLRequest(URL: NSURL(string: url)!)
        let urlSesion = NSURLSession.sharedSession()
        let task = urlSesion.dataTaskWithRequest(reques,completionHandler: {(data,response,error)->Void in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                self.weather = self.parseJsonData(data)
                
                NSOperationQueue.mainQueue().addOperationWithBlock({()-> Void in
                    self.tableView.reloadData()
                })
                
            }
        })
        task.resume()
    }
    
    func parseJsonData(data:NSData) -> [WeatherHourly]{
        do{
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            if let root = jsonResult!["hourly_forecast"] as? NSArray{
                for data in root{
                    
                    let dataAboutWeather = WeatherHourly()
                    
                    
                    if let time = data["FCTTIME"] as? NSDictionary{
                        dataAboutWeather.hour = time["hour"] as! String
                        
                    }
                    if let temp = data["temp"] as? NSDictionary{
                        dataAboutWeather.temperature = temp["metric"] as! String
                    }
                    dataAboutWeather.typeWeather = data["condition"] as! String
                    
                    weather.append(dataAboutWeather)
                 }
            }
        }catch{
            print(error)
        }
        return weather
    
    }

}
