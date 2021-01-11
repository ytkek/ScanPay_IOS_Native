//
//  DiscoveryTable.swift
//  user
//
//  Created by Kek on 13/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DiscoveryTable: UITableViewController
{
@IBOutlet var tableview1: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableview1.tableFooterView = UIView()
        tableview1.estimatedRowHeight = 300
    }

   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
   {
        var cellHeight:CGFloat = CGFloat()
        cellHeight = UIScreen.main.bounds.height
        return cellHeight
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            return 1
        }

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "discoverycell", for: indexPath) as! DiscoveryCell
            cell.viewController = self
            cell.selectionStyle = .none
            return cell
        }
       
}



extension DiscoveryTable: IndicatorInfoProvider{
       func indicatorInfo(for pagerTabStripController : PagerTabStripViewController) ->
           IndicatorInfo{
            return IndicatorInfo(image: UIImage(named : "discovery"))
           }
       
       }
