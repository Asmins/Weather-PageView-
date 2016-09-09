//
//  UIViewController+Extensions.swift
//  Weather
//
//  Created by admin on 09.09.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func instantiateFromStoryboard() -> Self {
        return instantiateFromStoryboardHelper(self, storyboardName: "Main")
    }
    
    class func instantiateFromStoryboard(storyboardName: String) -> Self {
        return instantiateFromStoryboardHelper(self, storyboardName: storyboardName)
    }
    
    private class func instantiateFromStoryboardHelper<T>(type: T.Type, storyboardName: String) -> T {
        var storyboardId = ""
        let classString : String = NSStringFromClass(self.classForCoder())
        let components = classString.componentsSeparatedByString(".")
        
        if components.count > 1
        {
            storyboardId = components[1]
        }
        let storyboad = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboad.instantiateViewControllerWithIdentifier(storyboardId) as! T
        
        return controller
    }
    
}

