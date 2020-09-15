//
//  AppDelegate.swift
//  user
//
//  Created by Kek on 09/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit
import DropDown
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DropDown.startListeningToKeyboard()
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in})
            
        }
        else
        {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types:[.alert, .badge, .sound],categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        return true
    }
    
    func application(_application: UIApplication, didReceiveRemoteNotification userInfo:[AnyHashable:Any])
    {
        
        print(userInfo)
    }
    func application (_application: UIApplication, didReceiveRemoteNotification userInfo:[AnyHashable:Any], fetchCompletionHandler completionHandler: @escaping(UIBackgroundFetchResult) -> Void)
    {
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    func application(_application: UIApplication, didFailToRegisterForRemoteNotificationWithError error: Error)
    {
        
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,  willPresent notification: UNNotification, withCompletionHandler   completionHandler: @escaping (_ options:   UNNotificationPresentationOptions) -> Void) {

        // custom code to handle push while app is in the foreground
        print("Handle push from foreground\(notification.request.content.userInfo)")

       // let dict = notification.request.content.userInfo["aps"] as! NSDictionary

     //  print(dict)

     //        let d : [String : Any] = dict["alert"] as! [String : Any]
     //        let body : String = d["body"] as! String
     //        let title : String = d["title"] as! String

     //
       //        print("Title:\(title) + body:\(body)")
      //
      //
      //
      //        self.showAlertAppDelegate(title:    title,message:body,buttonTitle:"ok",window:self.window!)


        completionHandler([[.alert,.sound]])


    }

    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // if you set a member variable in didReceiveRemoteNotification, you  will know if this is from closed or background


       


        



        print("Handle push from background or closed\(response.notification.request.content.userInfo)")
    }
    

    // MARK: UISceneSession Lifecycle

}

