//
//  NowViewController.swift
//  Weather
//
//  Created by admin on 18.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit

class NowViewController: UIViewController {

    @IBOutlet weak var labelForCurrentTemperature: UILabel!
    @IBOutlet weak var labelForTypeWeather: UILabel!
    @IBOutlet weak var labelForNextDayTypeWeather: UILabel!
    
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var labelForNextDayForTemperature: UILabel!
    @IBOutlet weak var labelForHumidity: UILabel!
    
    @IBOutlet weak var labelForUvIndex: UILabel!
    
    @IBOutlet weak var labelForWindSpeed: UILabel!
    
    @IBOutlet weak var imageForTypeWeather: UIImageView!
    
    @IBOutlet weak var activitityInd: UIActivityIndicatorView!
    var manager = CityManager()
    var weatherDaily = [WeatherDaily]()
    var uvIndex = 0.0
    
    func getDataAboutWeather(url:String){
        
        let request = NSURLRequest(URL: NSURL(string: url)!)
        let urlSesion = NSURLSession.sharedSession()
        
        let task = urlSesion.dataTaskWithRequest(request, completionHandler: {(data,respone,error) -> Void in
        
            dispatch_async(dispatch_get_main_queue()) {
            if let error = error{
                print(error)
                return
            }
            if let data = data{
                
                self.weatherDaily = self.parseJsonDataForWeatherDaily(data)
                
                }
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
                          
                            if let date = data["date"] as? [String:AnyObject]{
                                dataAboutWeather.day = date["day"] as! Int
                                dataAboutWeather.month = date["month"] as! Int
                                dataAboutWeather.nameMonth = date["monthname"] as! String
                                dataAboutWeather.weekDay = date["weekday"] as! String
                                
                            }
                            
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
                        self.labelForWindSpeed.text = "\(self.weatherDaily[0].wind_speed) KM/H"
                        self.labelForHumidity.text = "\(self.weatherDaily[0].humidity)%"
                        self.labelForTypeWeather.text = self.weatherDaily[0].typeWeatherForDaily
                        self.labelForCurrentTemperature.text = "\(self.weatherDaily[0].highTemperature)°"
                        self.labelForNextDayTypeWeather.text = self.weatherDaily[1].typeWeatherForDaily
                        self.labelForNextDayForTemperature.text = "\(self.weatherDaily[1].highTemperature)°"
                        setImageView()
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
            }else if (jsonResult!["code"] as? Int) != nil{
                labelForUvIndex.text = "N/A"
                labelForUvIndex.textColor = UIColor.redColor()
            }
        }catch{
            print(error)
        }
        return weatherDaily
    }
    
    func setImageView(){
        if weatherDaily[0].typeWeatherForDaily == "Overcast"{
            mainImageView.image = UIImage(named: "overCast")
            imageForTypeWeather.image = UIImage(named: "CloudIcon")
        }else if weatherDaily[0].typeWeatherForDaily == "Clear"{
            mainImageView.image = UIImage(named: "clear")
            imageForTypeWeather.image = UIImage(named: "sun")
        }else if weatherDaily[0].typeWeatherForDaily == "Chance of Rain"{
            mainImageView.image = UIImage(named: "rain")
            imageForTypeWeather.image = UIImage(named: "RainIcon")
        }else if weatherDaily[0].typeWeatherForDaily == "Partly Cloudy"{
            mainImageView.image = UIImage(named: "cloudy")
            imageForTypeWeather.image = UIImage(named: "CloudIcon")
        }else if weatherDaily[0].typeWeatherForDaily == "Chance of a Thunderstorm"{
            mainImageView.image = UIImage(named: "storm-1")
            imageForTypeWeather.image = UIImage(named: "storm")
        }else if weatherDaily[0].typeWeatherForDaily == "Thunderstorm"{
            mainImageView.image = UIImage(named: "storm-1")
            imageForTypeWeather.image = UIImage(named: "storm")
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "moreDetail"{
            let destinationController = segue.destinationViewController as! MoreDetailViewController
            destinationController.date = "\(self.weatherDaily[0].day)/\(self.weatherDaily[0].month)"
            destinationController.highTemperature = "\(self.weatherDaily[0].highTemperature)°"
            destinationController.lowTemperature = "\(self.weatherDaily[0].lowTemperature)°"
            destinationController.humidity = "\(self.weatherDaily[0].humidity)%"
            destinationController.windSpeed = "\(self.weatherDaily[0].wind_speed)KM/H"
            destinationController.weekDay = self.weatherDaily[0].weekDay
            destinationController.nameMonth = self.weatherDaily[0].nameMonth
            destinationController.typeWeather = self.weatherDaily[0].typeWeatherForDaily
            destinationController.uvIndex = labelForUvIndex.text!
            
            
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        weatherDaily = []
        getDataAboutWeather("http://api.wunderground.com/api/4ed7dad052717db4/forecast10day/q/\(manager.getLat()),\(manager.getLong()).json")
        getDataAboutWeather("http://api.owm.io/air/1.0/uvi/current?lat=\(manager.getLat())&lon=\(manager.getLong())&appid=fe96847f962cbea42c4d879c33daf010")
        
        
        
    }
    
    
    
    @IBAction func moreDetail(sender: AnyObject) {
        
    }

 

}
