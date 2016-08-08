//
//  DailyMoreDetail.swift
//  Weather
//
//  Created by admin on 27.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit

class DailyMoreDetail: UIViewController {
    
    @IBOutlet weak var labelForDate: UILabel!
    @IBOutlet weak var labelForWeekDay: UILabel!
    @IBOutlet weak var labelForNameMonth: UILabel!
    @IBOutlet weak var labelForTypeWeather: UILabel!
    @IBOutlet weak var labelForHumidity: UILabel!
    @IBOutlet weak var labelForTempHigh: UILabel!
    @IBOutlet weak var labelForTempLow: UILabel!
    @IBOutlet weak var labelForWindSpeed: UILabel!
    
    
    
    var date = " "
    var weekDay = " "
    var nameMonth = " "
    var typeWeather = " "
    var humidity = " "
    var tempHigh = " "
    var tempLow = " "
    var windSpeed = " "
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelForDate.text = date
        labelForWeekDay.text = weekDay
        labelForNameMonth.text = nameMonth
        labelForTypeWeather.text = typeWeather
        labelForHumidity.text = humidity
        labelForTempHigh.text = tempHigh
        labelForTempLow.text = tempLow
        labelForWindSpeed.text = windSpeed
        
    }
    
    @IBAction func backToViewController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
