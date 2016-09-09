//
//  HourlyViewController.swift
//  Weather
//
//  Created by admin on 18.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON

class HourlyViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = HourlyViewModel()
   
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setupTableView(tableView)
        self.viewModel.weather = []
        getWeather("http://api.wunderground.com/api/\(self.viewModel.apiKey)/hourly/q/\(self.viewModel.manager.getLat()),\(self.viewModel.manager.getLong()).json")
    }
    
    func getWeather(url:String){
        let reques = NSURLRequest(URL: NSURL(string:url)!)
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
}

private extension HourlyViewController {

    func setupTableView(tableView:UITableView) {
        tableView.registerNib(HourlyTableViewCell.getNib(), forCellReuseIdentifier: HourlyTableViewCell.getReuseIdentifier())
    }
    
}

extension HourlyViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(HourlyTableViewCell.getReuseIdentifier()) as! HourlyTableViewCell
        
        if self.viewModel.weather.isEmpty != true{
            switch self.viewModel.tempManager.getCheck() {
            case true:
                cell.tempLabel.text = "\(self.viewModel.weather[indexPath.row].tempFahrenheit)°"
            case false:
                cell.tempLabel.text = "\(self.viewModel.weather[indexPath.row].temperature)°"
            }
            cell.timeLabel.text = "\(self.viewModel.weather[indexPath.row].hour):00"
            cell.typeWeatherLabel.text = "\(self.viewModel.weather[indexPath.row].typeWeather)"
            cell.url = self.viewModel.weather[indexPath.row].url
            let imageURL:NSURL = NSURL.init(string: cell.url)!
            cell.iconImageView.sd_setImageWithURL(imageURL)
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.weather.count
    }
}

extension HourlyViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
}
