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
    
    @IBOutlet weak var activitityInd: UIActivityIndicatorView!
    
    var weatherDaily = [WeatherDaily]()
    
                                                                            //(lat),(lon)
    let urlDaily = "http://api.wunderground.com/api/4ed7dad052717db4/forecast10day/q/34,-118.json"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataAboutWeather(urlDaily)
        
        let alert = UIAlertController(title: "Alert", message: "Please wait 5 or 10 seconds for load data weather", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Enter", style: UIAlertActionStyle.Default, handler: {action in
            switch action.style{
            case .Default:
                print(self.weatherDaily[0].humidity)
                print("Some Action")
            default:
                print("Error")
        }
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    
    }
    

    
    func getDataAboutWeather(url:String){
        
        let request = NSURLRequest(URL: NSURL(string: url)!)
        let urlSesion = NSURLSession.sharedSession()
        
        let task = urlSesion.dataTaskWithRequest(request, completionHandler: {(data,respone,error) -> Void in
            if let error = error{
                print(error)
                return
            }
            if let data = data{
                
                self.weatherDaily = self.parseJsonDataForWeatherDaily(data)
                
            }
        })
        
        task.resume()
    }
    func parseJsonDataForWeatherDaily(data:NSData) -> [WeatherDaily ]{
        do{
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            if let root = jsonResult?["forecast"] as? [String:AnyObject] {
                if let simpleforecastItem = root["simpleforecast"] as? [String:AnyObject]{
                    if let forecastday = simpleforecastItem["forecastday"] as? [[String:AnyObject]] {
                        
                        for data in forecastday {
                            let dataAboutWeather = WeatherDaily()
                          
                            if let high = data["high"] as? [String:AnyObject]{
                                dataAboutWeather.highTemperature = high["celsius"] as! String
                            }
                            if let low  = data["low"] as? [String:AnyObject]{
                                dataAboutWeather.lowTemperature = low["celsius"] as! String
                            }
                            if let windSpeed = data["avewind"] as? [String:AnyObject]{
                                dataAboutWeather.wind_speed = windSpeed["kph"] as! Int
                            }
                            dataAboutWeather.typeWeatherForDaily = data["conditions"] as! String
                            dataAboutWeather.humidity = data["avehumidity"] as! Int
                            weatherDaily.append(dataAboutWeather)
                        }
                    }
                }
            }
        }catch{
            print(error)
        }
        return weatherDaily
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    @IBAction func moreDetail(sender: AnyObject) {
        
        
    }

 

}
