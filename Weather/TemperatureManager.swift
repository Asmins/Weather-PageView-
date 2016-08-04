//
//  TemperatureManager.swift
//  Weather
//
//  Created by admin on 04.08.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import Foundation


class TemperatureManager {
   
    
    var check = NSUserDefaults.standardUserDefaults()
    
    func setCheck(check:Bool){
        self.check.setBool(check, forKey:"true/false")
    }
    func getCheck() -> Bool {
        return self.check.boolForKey("true/false")
    }
    
}