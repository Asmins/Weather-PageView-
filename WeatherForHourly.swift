//
//  WeatherForHourly.swift
//  Weather
//
//  Created by admin on 19.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import Foundation
import CoreData


class WeatherForHourly: NSManagedObject {

    @NSManaged var temperature: String?
    @NSManaged var typeWeather: String?
    @NSManaged var hour: String
}
