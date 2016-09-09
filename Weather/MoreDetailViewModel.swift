//
//  MoreDetailViewModel.swift
//  Weather
//
//  Created by admin on 08.09.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import Foundation


class MoreDetailViewModel {
    var date:String!
    var weekDay:String!
    var nameMonth:String!
    var typeWeather:String!
    var uvIndex:String!
    var humidity:String!
    var highTemperature:String!
    var lowTemperature:String!
    var windSpeed:String

    init(date:String,weekDay:String,nameMonth:String,typeWeather:String,uvIndex:String,humidity:String,highTemperature:String,lowTemperature:String!,windSpeed:String){
        self.date = date
        self.weekDay = weekDay
        self.nameMonth = nameMonth
        self.typeWeather = typeWeather
        self.uvIndex = uvIndex
        self.humidity = humidity
        self.highTemperature = highTemperature
        self.lowTemperature = lowTemperature
        self.windSpeed = windSpeed
    }
    
}

