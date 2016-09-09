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
    
    var viewModel = NowViewModel()
    var weatherDaily = [WeatherDaily]()
    
    func getDataAboutWeather(url:String) {
        
        let request = NSURLRequest(URL: NSURL(string: url)!)
        let urlSesion = NSURLSession.sharedSession()
        
        let task = urlSesion.dataTaskWithRequest(request, completionHandler: {(data,respone,error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                if let error = error{
                    print(error)
                    return
                }
                if let data = data{
                    self.weatherDaily = []
                    self.weatherDaily = self.viewModel.parseJsonDataForWeatherDaily(data)
                    self.setupLabel()
                    self.setImageView()
                }
            }
        })
        task.resume()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewModelF = MoreDetailViewModel(date: "\(self.weatherDaily[0].day)/\(self.weatherDaily[0].month)", weekDay: self.weatherDaily[0].weekDay, nameMonth: self.weatherDaily[0].nameMonth, typeWeather: self.weatherDaily[0].typeWeatherForDaily, uvIndex: self.weatherDaily[0].uvIndex, humidity: "\(self.weatherDaily[0].humidity)%", highTemperature: "\(self.weatherDaily[0].highTemperatureFahrenheit)°", lowTemperature: "\(self.weatherDaily[0].lowTemperatureFahrenheit)°", windSpeed: "\(self.weatherDaily[0].wind_speed)KM/H")
        
        let viewModelC = MoreDetailViewModel(date: "\(self.weatherDaily[0].day)/\(self.weatherDaily[0].month)", weekDay: self.weatherDaily[0].weekDay, nameMonth: self.weatherDaily[0].nameMonth, typeWeather: self.weatherDaily[0].typeWeatherForDaily, uvIndex: self.weatherDaily[0].uvIndex, humidity: "\(self.weatherDaily[0].humidity)%", highTemperature: "\(self.weatherDaily[0].highTemperature)°", lowTemperature: "\(self.weatherDaily[0].lowTemperature)°", windSpeed: "\(self.weatherDaily[0].wind_speed)KM/H")
        
        if segue.identifier == "moreDetail"{
            let destinationController = segue.destinationViewController as! UINavigationController
            let targetController = destinationController.topViewController as! MoreDetailViewController
            switch self.viewModel.managerTemp.getCheck(){
                
            case true:
                targetController.viewModel = viewModelF
            case false:
                targetController.viewModel = viewModelC
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getDataAboutWeather("http://api.wunderground.com/api/\(self.viewModel.apiKey)/forecast10day/q/\(self.viewModel.manager.getLat()),\(self.viewModel.manager.getLong()).json")
    }
}

private extension NowViewController {
    func setupLabel() {
        if weatherDaily.isEmpty != true {
            switch self.viewModel.managerTemp.getCheck() {
            case true:
                labelForCurrentTemperature.text = "\(self.weatherDaily[0].highTemperatureFahrenheit)°"
                labelForNextDayForTemperature.text = "\(self.weatherDaily[1].highTemperatureFahrenheit)°"
            case false:
                labelForCurrentTemperature.text = "\(self.weatherDaily[0].highTemperature)°"
                labelForNextDayForTemperature.text = "\(self.weatherDaily[1].highTemperature)°"
            }
            labelForWindSpeed.text = "\(self.weatherDaily[0].wind_speed) KM/H"
            labelForHumidity.text = "\(self.weatherDaily[0].humidity)%"
            labelForTypeWeather.text = self.weatherDaily[0].typeWeatherForDaily
            labelForNextDayTypeWeather.text = self.weatherDaily[1].typeWeatherForDaily
        }
    }
    
    func setImageView(){
        
        if weatherDaily.isEmpty == false {
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
    }
}

