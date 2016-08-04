//
//  Weather.swift
//  Weather
//
//  Created by admin on 19.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import Foundation

class WeatherDaily{

    var typeWeatherForDaily = " "
    var lowTemperature = " "
    var lowTemperatureFahrenheit = " "
    var highTemperature = " "
    var highTemperatureFahrenheit = " "
    var day = 0
    var month = 0
    var nameMonth = " "
    var weekDay = " "
    var humidity = 0
    var wind_speed = 0
    var uvIndex = " "
    var url = " "
    
    
    var avarageTemperature:Int{
        return (Int(highTemperature)! + Int(lowTemperature)!) / 2
    }
}