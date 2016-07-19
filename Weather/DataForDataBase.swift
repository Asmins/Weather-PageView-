//
//  DataForDataBase.swift
//  Weather
//
//  Created by admin on 19.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import Foundation
import CoreData

class DataForBD{
 
    
    var weatherDaily  = [WeatherDaily]()
    var weatherHoury = [WeatherHourly]()
    
    var arrayUrl = [String]()
    
    func getDataAboutWeather(url:String){
    
        let request = NSURLRequest(URL: NSURL(string: url)!)
        let urlSesion = NSURLSession.sharedSession()
    
        let task = urlSesion.dataTaskWithRequest(request, completionHandler: {(data,respone,error) -> Void in
            if let error = error{
                print(error)
                return
            }
            if let data = data{
                self.weatherDaily = self.parseJsonDataForWeatherDaily(data)
                self.weatherHoury = self.parseJsonDataForWeatherHourly(data)
            }
            
            
        })
        
        task.resume()
        
        
    }
    
    
    func parseJsonDataForWeatherHourly(data:NSData) -> [WeatherHourly ]{
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
                    weatherHoury.append(dataAboutWeather)
                    
                }
                
                weatherHoury[0...9] = []
            }
        }catch{
            print(error)
        }
        return weatherHoury
    }
    
    func parseJsonDataForWeatherDaily(data:NSData) -> [WeatherDaily ]{
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
                            }
                        
                            if let high = data["high"] as? [String:AnyObject]{
                                dataAboutWeather.highTemperature = high["celsius"] as! String
                            }
                            if let low  = data["low"] as? [String:AnyObject]{
                                dataAboutWeather.lowTemperature = low["celsius"] as! String
                            }
                            if let windSpeed = data["avewind"] as? [String:AnyObject]{
                                dataAboutWeather.wind_speed = windSpeed["kph"] as! Int
                             }
                            dataAboutWeather.typeWeatherForDaily = data["conditions"] as! String
                            dataAboutWeather.humidity = data["avehumidity"] as! Int
                            weatherDaily.append(dataAboutWeather)
                        }
                    }
                }
            }
        }catch{
            print(error)
        }
        return weatherDaily
    }
    
}