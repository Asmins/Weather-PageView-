//
//  WeatherForCurrent.swift
//  Weather
//
//  Created by admin on 19.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import Foundation
import CoreData


class WeatherForCurrent: NSManagedObject {
   
    @NSManaged var typeWeather: String?
    @NSManaged var temperature: String?
    @NSManaged var humidity: String?
    @NSManaged var windSpeed: String?
    

}
