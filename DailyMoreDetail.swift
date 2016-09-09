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
    
    var viewModel:DailyMoreDetailViewModel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        labelForDate.text = self.viewModel.date
        labelForWeekDay.text = self.viewModel.weekDay
        labelForNameMonth.text = self.viewModel.nameMonth
        labelForTypeWeather.text = self.viewModel.typeWeather
        labelForHumidity.text = self.viewModel.humidity
        labelForTempHigh.text = self.viewModel.tempHigh
        labelForTempLow.text = self.viewModel.tempLow
        labelForWindSpeed.text = self.viewModel.windSpeed
    }
    
    @IBAction func backToViewController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}