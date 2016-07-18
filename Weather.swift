//
//  Weather.swift
//  Weather
//
//  Created by admin on 18.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import Foundation
import CoreData


class Weather: NSManagedObject {
    
    
    @NSManaged var typeWeather: String?
    @NSManaged var temperature: String?
    @NSManaged var uvIndex: String?
    @NSManaged var hour: String?
    @NSManaged var date: String?
    @NSManaged var windSpeed: String?
    @NSManaged var humidity: String?
    @NSManaged var high_low: String?
    
    
}
