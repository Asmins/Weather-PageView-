//
//  ViewControllerForSlide.swift
//  Weather
//
//  Created by admin on 04.08.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit

class ViewControllerForSlide: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    var manager = CityManager()
    
    @IBOutlet weak var labelForNameCity: UILabel!
    @IBOutlet weak var labelForTemperature: UILabel!
    
    var array = ["Set City"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        labelForNameCity.text = "\(manager.getName())"
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(array[indexPath.row], forIndexPath: indexPath) as! CustomTableViewCellForSlideMenu
        cell.labelForItems.text = array[indexPath.row]
        cell.imageViewForItem.image = UIImage(named: "Map Marker Filled-50")
        return  cell
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
