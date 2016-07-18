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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func moreDetail(sender: AnyObject) {
        
        
    }
    @IBAction func showHourlyView(sender: AnyObject) {
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
