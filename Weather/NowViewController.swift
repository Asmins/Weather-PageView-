//
//  NowViewController.swift
//  Weather
//
//  Created by admin on 18.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit

class NowViewController: UIViewController {

    @IBOutlet weak var labelForTypeWeather: UILabel!
    
    @IBOutlet weak var labelForTemperature: UILabel!
    
    @IBOutlet weak var labelForHumidity: UILabel!
    
    @IBOutlet weak var labelForUvIndex: UILabel!
    
    @IBOutlet weak var labelForWindSpeed: UILabel!
    
    @IBOutlet weak var imageForTypeWeather: UIImageView!
    
                                                                            //(lat),(lon)
    let urlHourly = "http://api.wunderground.com/api/4ed7dad052717db4/hourly/q/34,-118.json"
    let urlDaily = "http://api.wunderground.com/api/4ed7dad052717db4/forecast10day/q/34,-118.json"
    let urlCurrent = "http://api.wunderground.com/api/4ed7dad052717db4/forecast/q/34,-118.json"
    
    
    var data = DataForBD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data.getDataAboutWeather(urlDaily)
    }

    
    
    @IBAction func moreDetail(sender: AnyObject) {
        
        
    }
    @IBAction func showHourlyView(sender: AnyObject) {
    
    }

 

}
