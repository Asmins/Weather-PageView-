//
//  NowViewModel.swift
//  Weather
//
//  Created by admin on 08.09.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import Foundation
import SwiftyJSON

class NowViewModel {
    
    var manager = CityManager()
    var managerTemp = TemperatureManager()
    var weatherDaily = [WeatherDaily]()
    var foreCast = ForeCast()
    var simpleForeCast = SimpleForeCast()
    var foreCastDay = ForeCastDay()
    
    var apiKey = "1caf9f89914beb53"
    
    func parseJsonDataForWeatherDaily(data:NSData) -> [WeatherDaily]{
        weatherDaily = []
        do{
            let json = JSON(data:data)
            let forecast = json["forecast"]
            foreCast.simpleforecast = forecast["simpleforecast"]
            simpleForeCast.forecastday = foreCast.simpleforecast["forecastday"]
            
            for i in 0..<simpleForeCast.forecastday.count{
                let dataAboutWeather = WeatherDaily()
                foreCastDay.date = simpleForeCast.forecastday[i]["date"]
                foreCastDay.highTemp = simpleForeCast.forecastday[i]["high"]
                foreCastDay.lowTemp = simpleForeCast.forecastday[i]["low"]
                foreCastDay.humidity = simpleForeCast.forecastday[i]["avehumidity"]
                foreCastDay.typeWeather = simpleForeCast.forecastday[i]["conditions"]
                foreCastDay.wind = simpleForeCast.forecastday[i]["avewind"]
                
                dataAboutWeather.typeWeatherForDaily = foreCastDay.typeWeather.stringValue
                dataAboutWeather.day = foreCastDay.date["day"].int!
                dataAboutWeather.month = foreCastDay.date["month"].int!
                dataAboutWeather.nameMonth = foreCastDay.date["monthname"].stringValue
                dataAboutWeather.weekDay = foreCastDay.date["weekday"].stringValue
                dataAboutWeather.highTemperature = foreCastDay.highTemp["celsius"].stringValue
                dataAboutWeather.highTemperatureFahrenheit = foreCastDay.highTemp["fahrenheit"].stringValue
                dataAboutWeather.lowTemperature = foreCastDay.lowTemp["celsius"].stringValue
                dataAboutWeather.lowTemperatureFahrenheit = foreCastDay.lowTemp["fahrenheit"].stringValue
                dataAboutWeather.humidity = foreCastDay.humidity.int!
                dataAboutWeather.wind_speed = foreCastDay.wind["kph"].int!
                
                weatherDaily.append(dataAboutWeather)
            }
        }
        return weatherDaily
    }
}