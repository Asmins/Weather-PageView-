//
//  UIView+Extenstions.swift
//  Weather
//
//  Created by admin on 09.09.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit


extension UIView {
    
    public class func getNib() -> UINib? {
        let classString : String = NSStringFromClass(self.classForCoder())
        if let className = classString.componentsSeparatedByString(".").last {
            return UINib(nibName:className , bundle: nil)
        }
        return nil
    }
    
    public class func getReuseIdentifier() -> String {
        return NSStringFromClass(self)
    }
}

