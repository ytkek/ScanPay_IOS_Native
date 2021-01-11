//
//  DiscoveryListView.swift
//  user
//
//  Created by Kek on 26/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class DiscoveryListView: UITableViewCell {
    @IBOutlet weak var cellimage: UIImageView!
    @IBOutlet weak var celltitle: UITextView!
    @IBOutlet weak var celldetail: UITextView!
    weak var viewController: UIViewController?
    @IBOutlet weak var more: UIView!
    @IBOutlet weak var share: UIView!
    var indexpath: IndexPath!
    static var shareurl = [String]()
    static var moreurl = [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
     
    let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(mymoreurl))
    let mytapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(myshareurl))
    self.more.addGestureRecognizer(mytapGestureRecognizer)
    self.share.addGestureRecognizer(mytapGestureRecognizer2)
        
    }
    @objc func myshareurl(recognizer: UITapGestureRecognizer){
         let message = "MyScanPay help you share"
             
        if let link = NSURL(string: DiscoveryListView.moreurl[indexpath.row])
               {
                let objectsToShare = [message,link] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
                self.viewController?.present(activityVC, animated: true, completion: nil)
               }
        
    }
    @objc func mymoreurl(_ sender: UITapGestureRecognizer){
        UIApplication.shared.openURL(NSURL(string:DiscoveryListView.moreurl[indexpath.row])! as URL)
        print("Error took place \(DiscoveryListView.moreurl[0])")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}

