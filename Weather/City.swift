//
//  City.swift
//  Weather
//
//  Created by admin on 02.08.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import Foundation


class City {
    var latitude:Double
    var longitude:Double
    //var nameCity:String
    
    
    init(lat:Double,lng:Double) {
        self.latitude = lat
        self.longitude = lng
    }
}