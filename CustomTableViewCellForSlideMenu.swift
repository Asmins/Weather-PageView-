//
//  CustomTableViewCellForSlideMenu.swift
//  Weather
//
//  Created by admin on 02.08.16.
//  Copyright © 2016 Mozi. All rights reserved.
//

import UIKit

class CustomTableViewCellForSlideMenu: UITableViewCell {

    @IBOutlet weak var imageViewForSlideItems: UIImageView!
    @IBOutlet weak var labelForSlideItems: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
