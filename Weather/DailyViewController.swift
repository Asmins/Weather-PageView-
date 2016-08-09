//
//  DailyViewController.swift
//  Weather
//
//  Created by admin on 18.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit
import SDWebImage
class DailyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var manager = CityManager()
    var tempManger = TemperatureManager()
    var apiKey = "1caf9f89914beb53"
    var weather = [WeatherDaily]()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        weather = []
        getWeather()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomTableViewCellForDaily
        
        if tempManger.getCheck() == false{
            cell.labelForHighLowTemperature.text = "\(weather[indexPath.row].highTemperature)°/\(weather[indexPath.row].lowTemperature)°"
        }else{
            cell.labelForHighLowTemperature.text = "\(weather[indexPath.row].highTemperatureFahrenheit)°/\(weather[indexPath.row].lowTemperatureFahrenheit)°"
        }
        
        cell.labelForDate.text = "\(weather[indexPath.row].day)/\(weather[indexPath.row].month)"
        cell.labelForTypeWeather.text = "\(weather[indexPath.row].typeWeatherForDaily)"
        
        cell.url = weather[indexPath.row].url
        let imageURL:NSURL = NSURL.init(string: cell.url)!
        
        cell.imageViewForTypeWeather.sd_setImageWithURL(imageURL)
        
        return cell
    }
    
    func getWeather(){
        let reques = NSURLRequest(URL: NSURL(string: "http://api.wunderground.com/api/\(apiKey)/forecast10day/q/\(manager.getLat()),\(manager.getLong()).json")!)
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
    
    func parseJsonData(data:NSData) -> [WeatherDaily ]{
        do{
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            if let root = jsonResult?["forecast"] as? [String:AnyObject] {
                if let simpleforecastItem = root["simpleforecast"] as? [String:AnyObject]{
                    if let forecastday = simpleforecastItem["forecastday"] as? [[String:AnyObject]] {
                        
                        for data in forecastday {
                            let dataAboutWeather = WeatherDaily()
                            
                            if let date = data["date"] as? [String:AnyObject]{
                                dataAboutWeather.day = date["day"] as! Int
                                dataAboutWeather.month = date["month"] as! Int
                                dataAboutWeather.nameMonth = date["monthname"] as! String
                                dataAboutWeather.weekDay = date["weekday"] as! String
                            }
                            
                            if let high = data["high"] as? [String:AnyObject]{
                                dataAboutWeather.highTemperature = high["celsius"] as! String
                                dataAboutWeather.highTemperatureFahrenheit = high["fahrenheit"] as! String
                            }
                            if let low  = data["low"] as? [String:AnyObject]{
                                dataAboutWeather.lowTemperature = low["celsius"] as! String
                                dataAboutWeather.lowTemperatureFahrenheit = low["fahrenheit"] as! String
                            }
                            if let windSpeed = data["avewind"] as? [String:AnyObject]{
                                dataAboutWeather.wind_speed = windSpeed["kph"] as! Int
                            }
                            dataAboutWeather.typeWeatherForDaily = data["conditions"] as! String
                            dataAboutWeather.humidity = data["avehumidity"] as! Int
                            dataAboutWeather.url = (data["icon_url"] as? String)!
                            
                            weather.append(dataAboutWeather)
                        }
                    }
                }
            }
        }catch{
            print("Error")
        }
        return weather
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DailyMoreDetail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destinationViewController as! UINavigationController
                let targetController = destinationController.topViewController as! DailyMoreDetail
                
                if tempManger.getCheck() == false{
                    targetController.tempHigh = "\(weather[indexPath.row].highTemperature)°"
                    targetController.tempLow = "\(weather[indexPath.row].lowTemperature)°"
                }else{
                    targetController.tempHigh = "\(weather[indexPath.row].highTemperatureFahrenheit)°"
                    targetController.tempLow = "\(weather[indexPath.row].lowTemperatureFahrenheit)°"
                }
                targetController.date = "\(weather[indexPath.row].day)/\(weather[indexPath.row].month)"
                targetController.weekDay = weather[indexPath.row].weekDay
                targetController.nameMonth = weather[indexPath.row].nameMonth
                targetController.typeWeather = weather[indexPath.row].typeWeatherForDaily
                
                targetController.humidity = "\(weather[indexPath.row].humidity)%"
                targetController.windSpeed = "\(weather[indexPath.row].wind_speed)Km/H"
            }
        }
    }
    
    
}
