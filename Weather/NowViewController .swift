import UIKit
import SwiftyJSON

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
    
    var foreCast = ForeCast()
    var simpleForeCast = SimpleForeCast()
    var foreCastDay = ForeCastDay()
    
    var apiKey = "1caf9f89914beb53"
    
    var manager = CityManager()
    var managerTemp = TemperatureManager()
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
            
            let json = JSON(data:data)
            let forecast = json["forecast"]
            foreCast.simpleforecast = forecast["simpleforecast"]
            simpleForeCast.forecastday = foreCast.simpleforecast["forecastday"]
            
            for i in 0..<simpleForeCast.forecastday.count{
                let dataAboutWeather = WeatherDaily()
                foreCastDay.date = simpleForeCast.forecastday[i]["date"]
                foreCastDay.highTemp = simpleForeCast.forecastday[i]["high"]
                foreCastDay.lowTemp = simpleForeCast.forecastday[i]["low"]
                foreCastDay.humidity = simpleForeCast.forecastday[i]["avehumidity"]
                foreCastDay.typeWeather = simpleForeCast.forecastday[i]["conditions"]
                foreCastDay.wind = simpleForeCast.forecastday[i]["avewind"]
                
                dataAboutWeather.typeWeatherForDaily = foreCastDay.typeWeather.stringValue
                dataAboutWeather.day = foreCastDay.date["day"].int!
                dataAboutWeather.month = foreCastDay.date["month"].int!
                dataAboutWeather.nameMonth = foreCastDay.date["monthname"].stringValue
                dataAboutWeather.weekDay = foreCastDay.date["weekday"].stringValue
                dataAboutWeather.highTemperature = foreCastDay.highTemp["celsius"].stringValue
                dataAboutWeather.highTemperatureFahrenheit = foreCastDay.highTemp["fahrenheit"].stringValue
                dataAboutWeather.lowTemperature = foreCastDay.lowTemp["celsius"].stringValue
                dataAboutWeather.lowTemperatureFahrenheit = foreCastDay.lowTemp["fahrenheit"].stringValue
                dataAboutWeather.humidity = foreCastDay.humidity.int!
                dataAboutWeather.wind_speed = foreCastDay.wind["kph"].int!
                
                weatherDaily.append(dataAboutWeather)
            }
            
            if weatherDaily.isEmpty{
                
            }else{
                if managerTemp.getCheck() == false{
                    labelForCurrentTemperature.text = "\(self.weatherDaily[0].highTemperature)°"
                    labelForNextDayForTemperature.text = "\(self.weatherDaily[1].highTemperature)°"
                    
                }else{
                    labelForCurrentTemperature.text = "\(self.weatherDaily[0].highTemperatureFahrenheit)°"
                    labelForNextDayForTemperature.text = "\(self.weatherDaily[1].highTemperatureFahrenheit)°"
                }
                labelForWindSpeed.text = "\(self.weatherDaily[0].wind_speed) KM/H"
                labelForHumidity.text = "\(self.weatherDaily[0].humidity)%"
                labelForTypeWeather.text = weatherDaily[0].typeWeatherForDaily
                labelForNextDayTypeWeather.text = weatherDaily[1].typeWeatherForDaily
                setImageView()
            }
            
            if let valueUvIndex = jsonResult!["value"] as? Double{
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
        switch weatherDaily[0].typeWeatherForDaily {
        case "Overcast":
            mainImageView.image = UIImage(named: "overCast")
            imageForTypeWeather.image = UIImage(named: "CloudIcon")
        case "Clear":
            mainImageView.image = UIImage(named: "clear")
            imageForTypeWeather.image = UIImage(named: "sun")
        case "Chance of Rain":
            mainImageView.image = UIImage(named: "rain")
            imageForTypeWeather.image = UIImage(named: "RainIcon")
        case "Partly Cloudy":
            mainImageView.image = UIImage(named: "cloud")
            imageForTypeWeather.image = UIImage(named: "CloudIcon")
        case "Chance of a Thunderstorm":
            mainImageView.image = UIImage(named: "storm-1")
            imageForTypeWeather.image = UIImage(named: "storm")
        case "Thunderstorm":
            mainImageView.image = UIImage(named: "storm-1")
            imageForTypeWeather.image = UIImage(named: "storm")
        case "Rain":
            mainImageView.image = UIImage(named: "rain")
            imageForTypeWeather.image = UIImage(named: "RainIcon")
        case "Mostly Cloudy":
            mainImageView.image = UIImage(named: "cloud")
            imageForTypeWeather.image = UIImage(named: "CloudIcon")
        default:
            print("In latest update we add new feature")
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "moreDetail"{
            let destinationController = segue.destinationViewController as! UINavigationController
            let targetController = destinationController.topViewController as! MoreDetailViewController
            
            if managerTemp.getCheck() == false{
                targetController.highTemperature = "\(self.weatherDaily[0].highTemperature)°"
                targetController.lowTemperature = "\(self.weatherDaily[0].lowTemperature)°"
            }else{
                targetController.highTemperature = "\(self.weatherDaily[0].highTemperatureFahrenheit)°"
                targetController.lowTemperature = "\(self.weatherDaily[0].lowTemperatureFahrenheit)°"
            }
            
            targetController.date = "\(self.weatherDaily[0].day)/\(self.weatherDaily[0].month)"
            targetController.humidity = "\(self.weatherDaily[0].humidity)%"
            targetController.windSpeed = "\(self.weatherDaily[0].wind_speed)KM/H"
            targetController.weekDay = self.weatherDaily[0].weekDay
            targetController.nameMonth = self.weatherDaily[0].nameMonth
            targetController.typeWeather = self.weatherDaily[0].typeWeatherForDaily
            targetController.uvIndex = labelForUvIndex.text!
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        weatherDaily = []
        getDataAboutWeather("http://api.wunderground.com/api/\(apiKey)/forecast10day/q/\(manager.getLat()),\(manager.getLong()).json")
        getDataAboutWeather("http://api.owm.io/air/1.0/uvi/current?lat=\(manager.getLat())&lon=\(manager.getLong())&appid=fe96847f962cbea42c4d879c33daf010")
    }
}