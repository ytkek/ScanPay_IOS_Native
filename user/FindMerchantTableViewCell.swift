//
//  FindMerchantTableViewCell.swift
//  user
//
//  Created by Kek on 27/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class FindMerchantTableViewCell: UITableViewCell {

    @IBOutlet weak var cellimage: UIImageView!
   
    @IBOutlet weak var celltitle: UILabel!
    
    @IBOutlet weak var celldetail: UILabel!
    
    @IBOutlet weak var celldetail2: UILabel!
    
    @IBOutlet weak var celldetail3: UILabel!
    
    @IBOutlet weak var celltopup: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
