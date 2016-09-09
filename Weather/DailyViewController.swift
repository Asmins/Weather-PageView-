//
//  DailyViewController.swift
//  Weather
//
//  Created by admin on 18.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON

class DailyViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = DailyViewModel()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.weather = []
        getWeather()
    }
    
    func getWeather(){
        let reques = NSURLRequest(URL: NSURL(string: "http://api.wunderground.com/api/\(self.viewModel.apiKey)/forecast10day/q/\(self.viewModel.manager.getLat()),\(self.viewModel.manager.getLong()).json")!)
        let urlSesion = NSURLSession.sharedSession()
        let task = urlSesion.dataTaskWithRequest(reques,completionHandler: {(data,response,error)->Void in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                self.viewModel.weather = self.viewModel.parseJsonData(data)
                NSOperationQueue.mainQueue().addOperationWithBlock({()-> Void in
                    self.tableView.reloadData()
                })
            }
        })
        task.resume()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DailyMoreDetail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                
                let viewModelF = DailyMoreDetailViewModel(date: "\(self.viewModel.weather[indexPath.row].day)/\(self.viewModel.weather[indexPath.row].month)", weekDay: self.viewModel.weather[indexPath.row].weekDay, nameMonth: self.viewModel.weather[indexPath.row].nameMonth, typeWeather: self.viewModel.weather[indexPath.row].typeWeatherForDaily, humidity: "\(self.viewModel.weather[indexPath.row].humidity)%", tempHigh: "\(self.viewModel.weather[indexPath.row].highTemperatureFahrenheit)°", tempLow: "\(self.viewModel.weather[indexPath.row].lowTemperatureFahrenheit)°", windSpeed: "\(self.viewModel.weather[indexPath.row].wind_speed)Km/H")
                let viewModelC =  DailyMoreDetailViewModel(date: "\(self.viewModel.weather[indexPath.row].day)/\(self.viewModel.weather[indexPath.row].month)", weekDay: self.viewModel.weather[indexPath.row].weekDay, nameMonth: self.viewModel.weather[indexPath.row].nameMonth, typeWeather: self.viewModel.weather[indexPath.row].typeWeatherForDaily, humidity: "\(self.viewModel.weather[indexPath.row].humidity)%", tempHigh: "\(self.viewModel.weather[indexPath.row].highTemperature)°", tempLow: "\(self.viewModel.weather[indexPath.row].lowTemperature)°", windSpeed: "\(self.viewModel.weather[indexPath.row].wind_speed)Km/H")
                

                let destinationController = segue.destinationViewController as! UINavigationController
                let targetController = destinationController.topViewController as! DailyMoreDetail
                
                    switch self.viewModel.tempManger.getCheck() {
                case true:
                    targetController.viewModel = viewModelF
                case false:
                    targetController.viewModel = viewModelC
                }
            }
        }
    }
}

extension DailyViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomTableViewCellForDaily
        
        if self.viewModel.tempManger.getCheck() == false{
            cell.labelForHighLowTemperature.text = "\(self.viewModel.weather[indexPath.row].highTemperature)°/\(self.viewModel.weather[indexPath.row].lowTemperature)°"
        }else{
            cell.labelForHighLowTemperature.text = "\(self.viewModel.weather[indexPath.row].highTemperatureFahrenheit)°/\(self.viewModel.weather[indexPath.row].lowTemperatureFahrenheit)°"
        }
        
        cell.labelForDate.text = "\(self.viewModel.weather[indexPath.row].day)/\(self.viewModel.weather[indexPath.row].month)"
        cell.labelForTypeWeather.text = "\(self.viewModel.weather[indexPath.row].typeWeatherForDaily)"
        cell.url = self.viewModel.weather[indexPath.row].url
        let imageURL:NSURL = NSURL.init(string: cell.url)!
        cell.imageViewForTypeWeather.sd_setImageWithURL(imageURL)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.weather.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}

extension DailyViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
}

