//
//  DailyViewModel.swift
//  Weather
//
//  Created by admin on 09.09.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import Foundation
import SwiftyJSON

class DailyViewModel {
    var manager = CityManager()
    var tempManger = TemperatureManager()
    var apiKey = "1caf9f89914beb53"
    var weather = [WeatherDaily]()
    
    var foreCast = ForeCast()
    var simpleForeCast = SimpleForeCast()
    var foreCastDay = ForeCastDay()
    
    
    
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
}
