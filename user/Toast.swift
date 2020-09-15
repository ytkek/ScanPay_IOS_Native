//
//  Toast.swift
//  user
//
//  Created by Kek on 11/05/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import Foundation
import UIKit

class Toast : UIViewController{
    static func show(message: String, controller: UIViewController){
        let toastContainer = UIView(frame: CGRect())
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        
    }
    static func saveLoginID (loginid : String)
    {
         let loginID = UserDefaults.standard.set(loginid,forKey: "LoginID")
    }
    
    static func retreiveLoginID() -> String
       {
           let loginid = UserDefaults.standard.string(forKey: "LoginID") ?? ""
          return loginid
       }
    
    
}
