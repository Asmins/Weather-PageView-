//
//  TableViewContoller.swift
//  Weather
//
//  Created by admin on 02.08.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import Foundation


class TableViewController: UITableViewController {
    
    var array = ["Set City"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(array[indexPath.row], forIndexPath: indexPath) as! CustomTableViewCellForSlideMenu
        cell.labelForSlideItems.text = array[indexPath.row]
        cell.imageViewForSlideItems.image = UIImage(named:"Map Marker Filled-50")
        return  cell
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}