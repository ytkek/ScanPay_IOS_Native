//
//  LocationTableViewCell.swift
//  user
//
//  Created by Kek on 23/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var celltext: UILabel!

    @IBOutlet weak var cellimage: UIImageView!
    @IBOutlet weak var celldetail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
