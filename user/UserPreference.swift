//
//  UserPreference.swift
//  user
//
//  Created by Kek on 11/05/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import Foundation
import UIKit

class UserPreference :UIViewController{
    
    static func saveLoginID (loginid : String)
    {
         let loginID = UserDefaults.standard.set(loginid,forKey: "LoginID")
    }
    
    static func retreiveLoginID() -> String
       {
           let loginid = UserDefaults.standard.string(forKey: "LoginID") ?? ""
          return loginid
       }
    
    static func removeLoginID ()
    {
        UserDefaults.standard.removeObject(forKey: "LoginID")
        UserDefaults.standard.synchronize()
    }
    
    static func saveLoginPassword(loginpassword : String)
    {
         let loginpassword = UserDefaults.standard.set(loginpassword,forKey: "LoginPassword")
    }
    
    static func retreiveLoginPassword() -> String
       {
           let loginpassword = UserDefaults.standard.string(forKey: "LoginPassword") ?? ""
          return loginpassword
       }
    static func removeLoginPassword()
    {
        UserDefaults.standard.removeObject(forKey: "LoginPassword")
        UserDefaults.standard.synchronize()
    }
}
