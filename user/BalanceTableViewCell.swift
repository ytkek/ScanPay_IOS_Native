//
//  BalanceTableViewCell.swift
//  user
//
//  Created by Kek on 30/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class BalanceTableViewCell: UITableViewCell {

    @IBOutlet weak var celldate: UILabel!
    @IBOutlet weak var celltype: UILabel!
    @IBOutlet weak var cellreference: UILabel!
    @IBOutlet weak var cellamount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
