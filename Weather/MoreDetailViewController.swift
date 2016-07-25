//
//  MoreDetailViewController.swift
//  Weather
//
//  Created by admin on 24.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit

class MoreDetailViewController: UIViewController {

    @IBOutlet weak var labelForWindSpeed: UILabel!
    @IBOutlet weak var labelForHumidity: UILabel!
    @IBOutlet weak var labelForUvIndex: UILabel!
    @IBOutlet weak var labelForHighTemperature: UILabel!
    @IBOutlet weak var labelForLowTemperature: UILabel!
    @IBOutlet weak var labelForTypeWeather: UILabel!
    @IBOutlet weak var labelForMonth: UILabel!
    @IBOutlet weak var labelForDate: UILabel!
    @IBOutlet weak var labelForWeekDay: UILabel!
    
    var date = " "
    var weekDay = " "
    var nameMonth = " "
    var typeWeather = " "
    var uvIndex = " "
    var humidity =  " "
    var highTemperature = " "
    var lowTemperature = " "
    var windSpeed = " "
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelForTypeWeather.text = typeWeather
        labelForDate.text = date
        labelForMonth.text = nameMonth
        labelForUvIndex.text = uvIndex
        labelForLowTemperature.text = lowTemperature
        labelForHighTemperature.text = highTemperature
        labelForWeekDay.text = weekDay
        labelForWindSpeed.text = windSpeed
        labelForHumidity.text = humidity
    }

    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
