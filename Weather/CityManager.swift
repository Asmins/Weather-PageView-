//
//  CityManager.swift
//  Weather
//
//  Created by admin on 02.08.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import Foundation


class CityManager {
    
    var latitude = NSUserDefaults.standardUserDefaults()
    var longtitude = NSUserDefaults.standardUserDefaults()
    var cityName = NSUserDefaults.standardUserDefaults()
    
    func saveLat(lt:Double){
        self.latitude.setDouble(lt, forKey: "lt")
    }
    
    func saveLong(lng:Double){
        self.longtitude.setObject(lng, forKey: "lng")
    }
    func saveName(name:String){
        self.cityName.setObject(name, forKey: "nameCity")
    }
    
    func getLat()-> Double{
        if latitude.doubleForKey("lng") == 0 {
            return 49.6
        }
        return latitude.doubleForKey("lt")
    }
    func getLong() -> Double {
        if  longtitude.doubleForKey("lng") == 0{
            return 32.3
        }
        return longtitude.doubleForKey("lng")
    }
    
    func getName() -> String {
        if cityName.stringForKey("nameCity") == nil{
            return "Черкаси"
        }
        return cityName.stringForKey("nameCity")!
        
    }
    
}