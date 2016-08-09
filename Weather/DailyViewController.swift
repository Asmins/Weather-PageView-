//
//  DailyViewController.swift
//  Weather
//
//  Created by admin on 18.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON

class DailyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var manager = CityManager()
    var tempManger = TemperatureManager()
    var apiKey = "1caf9f89914beb53"
    var weather = [WeatherDaily]()
    
    var foreCast = ForeCast()
    var simpleForeCast = SimpleForeCast()
    var foreCastDay = ForeCastDay()
    
    
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
        let json = JSON(data:data)
        let forecast = json["forecast"]
        foreCast.simpleforecast = forecast["simpleforecast"]
        simpleForeCast.forecastday = foreCast.simpleforecast["forecastday"]
        
        for i in 0..<simpleForeCast.forecastday.count{
            let data = WeatherDaily()
            foreCastDay.date = simpleForeCast.forecastday[i]["date"]
            foreCastDay.highTemp = simpleForeCast.forecastday[i]["high"]
            foreCastDay.lowTemp = simpleForeCast.forecastday[i]["low"]
            foreCastDay.humidity = simpleForeCast.forecastday[i]["avehumidity"]
            foreCastDay.wind = simpleForeCast.forecastday[i]["avewind"]
            foreCastDay.typeWeather = simpleForeCast.forecastday[i]["conditions"]
            //Other
            data.url = simpleForeCast.forecastday[i]["icon_url"].stringValue
            //TypeWeather
            data.typeWeatherForDaily = foreCastDay.typeWeather.stringValue
            //TEMP
            data.highTemperature = foreCastDay.highTemp["celsius"].stringValue
            data.highTemperatureFahrenheit = foreCastDay.highTemp["fahrenheit"].stringValue
            data.lowTemperature = foreCastDay.lowTemp["celsius"].stringValue
            data.lowTemperatureFahrenheit = foreCastDay.lowTemp["fahrenheit"].stringValue
            //DATE
            data.day = foreCastDay.date["day"].int!
            data.month = foreCastDay.date["month"].int!
            data.nameMonth = foreCastDay.date["monthname"].stringValue
            data.weekDay = foreCastDay.date["weekday"].stringValue
            //WIND
            data.wind_speed = foreCastDay.wind["kph"].int!
            //HUMIDITY
            data.humidity = foreCastDay.humidity.int!
            weather.append(data)
        }
        return weather
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DailyMoreDetail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destinationViewController as! UINavigationController
                let targetController = destinationController.topViewController as! DailyMoreDetail
                if weather.isEmpty{
                    print("Error")
                }else{
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
}