//
//  MessageCenterDetail.swift
//  user
//
//  Created by Kek on 16/04/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class MessageCenterDetail: UIViewController {
   
    var date = ""
    var m_title = ""
    var message = ""
    @IBOutlet weak var message_date: UILabel!
    @IBOutlet weak var message_title: UILabel!
    @IBOutlet weak var message_message: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        let dateFrominputString = dateFormatter.date(from:date ?? "")
              
        if dateFrominputString == nil
        {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let dateFrominputString2 = dateFormatter.date(from:date ?? "")
            dateFormatter.dateFormat = "yyyy/MM/dd hh:mm:ss a"
            message_date.text? = dateFormatter.string(from: dateFrominputString2!)
        }
        else
        {
            dateFormatter.dateFormat = "yyyy/MM/dd hh:mm:ss a"
            message_date.text?  = dateFormatter.string(from: dateFrominputString!)
        }
        
            message_title.text = m_title
            message_message.text = message
        
    }
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

   

}
