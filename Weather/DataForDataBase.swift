//
//  DataForDataBase.swift
//  Weather
//
//  Created by admin on 19.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import Foundation


class DataForBD{
 
    
    var weather  = [Weather]()
    
    
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
                self.weather = self.parseJsonData(data)
                
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
                        dataAboutWeather.hour = time["hour"] as? String
                    }
                    if let temp = data["temp"] as? NSDictionary{
                        dataAboutWeather.temperature = temp["metric"] as? String
                    }
                    dataAboutWeather.humidity = data["humidity"] as? String
                    dataAboutWeather.typeWeather = data["condition"] as? String
                    weather.append(dataAboutWeather)
                }
                
                weather[0...9] = []
            }else if let root = jsonResult!["forecast"] as? [String:AnyObject]{
                if let simpleForecast = root["simpleforecast"] as? [String:AnyObject]{
                    if let forecastday = simpleForecast["forecastday"] as? [[String:AnyObject]]{
                        for data in forecastday{
                        
                        }
                    }
                }
            }
        }catch{
            print(error)
        }
        return weather
    }
    
}