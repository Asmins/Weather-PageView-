//
//  CustomTableViewCellForDaily.swift
//  Weather
//
//  Created by admin on 24.07.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit

class CustomTableViewCellForDaily: UITableViewCell {

    @IBOutlet weak var labelForDate: UILabel!
    @IBOutlet weak var imageViewForTypeWeather: UIImageView!
    @IBOutlet weak var labelForTypeWeather: UILabel!
    @IBOutlet weak var labelForHighLowTemperature: UILabel!
    
    
    var url = " "
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
