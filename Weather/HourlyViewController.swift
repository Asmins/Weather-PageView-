//
//  HourlyViewController.swift
//  Weather
//
//  Created by admin on 18.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON

class HourlyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
   
    var manager = CityManager()
    var tempManager = TemperatureManager()
    var weather = [WeatherHourly]()
    
    var apiKey = "1caf9f89914beb53"
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        weather = []
        getWeather()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomTableViewCell
        
        
        if tempManager.getCheck() == false{
            
            cell.labelForTemperature.text = "\(weather[indexPath.row].temperature)°"
        }
        else{
            cell.labelForTemperature.text = "\(weather[indexPath.row].tempFahrenheit)°"
        }
        cell.labelForHour.text = "\(weather[indexPath.row].hour):00"
        cell.labelForTypeWeather.text = "\(weather[indexPath.row].typeWeather)"
        
        cell.url = weather[indexPath.row].url
        let imageURL:NSURL = NSURL.init(string: cell.url)!
        
        cell.imageForWeather.sd_setImageWithURL(imageURL)
        
        return cell
    }
    
    func getWeather(){
        let reques = NSURLRequest(URL: NSURL(string: "http://api.wunderground.com/api/\(apiKey)/hourly/q/\(manager.getLat()),\(manager.getLong()).json")!)
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
            let json = JSON(data:data)
            let hourlyForeCast = json["hourly_forecast"]
            for i in 0..<hourlyForeCast.count{
                let data = WeatherHourly()
                data.hour = hourlyForeCast[i]["FCTTIME"]["hour"].stringValue
                data.temperature = hourlyForeCast[i]["temp"]["metric"].stringValue
                data.tempFahrenheit = hourlyForeCast[i]["temp"]["english"].stringValue
                data.typeWeather = hourlyForeCast[i]["condition"].stringValue
                data.url = hourlyForeCast[i]["icon_url"].stringValue
                weather.append(data)
            }
        }catch{
            print(error)
        }
        return weather
        
    }
    
}
