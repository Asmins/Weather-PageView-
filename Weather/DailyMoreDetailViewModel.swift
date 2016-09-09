//
//  DailyMoreDetailViewModel.swift
//  Weather
//
//  Created by admin on 09.09.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import Foundation

class DailyMoreDetailViewModel {
    
    var date:String!
    var weekDay:String!
    var nameMonth:String!
    var typeWeather:String!
    var humidity:String!
    var tempHigh:String!
    var tempLow:String!
    var windSpeed:String!
    
    init(date:String,weekDay:String,nameMonth:String,typeWeather:String,humidity:String,tempHigh:String,tempLow:String,windSpeed:String){
        self.date = date
        self.weekDay = weekDay
        self.nameMonth = nameMonth
        self.typeWeather = typeWeather
        self.humidity = humidity
        self.tempHigh = tempHigh
        self.tempLow = tempLow
        self.windSpeed = windSpeed
    }
    
}