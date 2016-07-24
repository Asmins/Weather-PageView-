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
    @IBOutlet weak var labelForNextDayTypeWeather: UILabel!
    
    @IBOutlet weak var labelForTemperature: UILabel!
    
    @IBOutlet weak var labelForNextDayForTemperature: UILabel!
    @IBOutlet weak var labelForHumidity: UILabel!
    
    @IBOutlet weak var labelForUvIndex: UILabel!
    
    @IBOutlet weak var labelForWindSpeed: UILabel!
    
    @IBOutlet weak var imageForTypeWeather: UIImageView!
    
    @IBOutlet weak var activitityInd: UIActivityIndicatorView!
    
    var weatherDaily = [WeatherDaily]()
    var uvIndex = 0.0
                                                                            //(lat),(lon)
    let urlDaily = "http://api.wunderground.com/api/4ed7dad052717db4/forecast10day/q/34,-118.json"
    let urlUvIndex = "http://api.owm.io/air/1.0/uvi/current?lat=34&lon=-118&appid=fe96847f962cbea42c4d879c33daf010"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataAboutWeather(urlDaily)
        getDataAboutWeather(urlUvIndex)
        let alert = UIAlertController(title: "Alert", message: "Please wait 5 or 10 seconds for load data weather", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Enter", style: UIAlertActionStyle.Default, handler: {action in
            switch action.style{
            case .Default:
                self.labelForWindSpeed.text = "\(self.weatherDaily[0].wind_speed) KM/H"
                self.labelForHumidity.text = "\(self.weatherDaily[0].humidity)%"
                self.labelForTypeWeather.text = self.weatherDaily[0].typeWeatherForDaily
                self.labelForTemperature.text = "\(self.weatherDaily[0].avarageTemperature)°"
                self.labelForNextDayTypeWeather.text = self.weatherDaily[1].typeWeatherForDaily
                self.labelForNextDayForTemperature.text = "\(self.weatherDaily[1].avarageTemperature)°"
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
            }else if let valueUvIndex = jsonResult!["value"] as? Double{
                switch valueUvIndex {
                case 0..<2.9 :
                    labelForUvIndex.text = "Low"
                case 3..<5.9 :
                    labelForUvIndex.text = "Modarate"
                case 6..<7.9 :
                    labelForUvIndex.text = "High"
                case 8..<10.9 :
                    labelForUvIndex.text = "Very High"
                case 11..<100 :
                    labelForUvIndex.text = "Extreme"
                default:
                    print("Error")
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
