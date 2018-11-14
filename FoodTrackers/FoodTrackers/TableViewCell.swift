//
//  tableViewCellTableViewCell.swift
//  FoodTrackers
//
//  Created by Admin on 11/6/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class tableViewCellTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var ratingControl: ratingControl!
    @IBOutlet weak var mealName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
