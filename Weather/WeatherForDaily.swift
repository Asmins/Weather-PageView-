//
//  WeatherForDaily.swift
//  Weather
//
//  Created by admin on 19.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import Foundation
import CoreData


class WeatherForDaily: NSManagedObject {

    
    @NSManaged var date: String?
    @NSManaged var lowTemperature: String?
    @NSManaged var highTemperature: UNKNOWN_TYPE
    @NSManaged var typeWeather: UNKNOWN_TYPE

}
