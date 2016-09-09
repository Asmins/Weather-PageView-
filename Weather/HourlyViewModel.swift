//
//  HourlyViewModel.swift
//  Weather
//
//  Created by admin on 09.09.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import Foundation
import SwiftyJSON

class HourlyViewModel {
    
    var manager = CityManager()
    var tempManager = TemperatureManager()
    var weather = [WeatherHourly]()
    var apiKey = "1caf9f89914beb53"
    
    func parseJsonData(data:NSData) -> [WeatherHourly]{
        
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
        return weather
    }
    
}