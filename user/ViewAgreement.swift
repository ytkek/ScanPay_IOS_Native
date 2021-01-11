//
//  ViewAgreement.swift
//  user
//
//  Created by Kek on 20/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit
import WebKit
class ViewAgreement: UIViewController, WKUIDelegate {

    var webview = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UIDevice.current.hasTopNotch {
            if Reachability.isConnectedToNetwork()
            {
                   let url = URL(string : "https://www.myscanpay.com/v4/mobile/PrivacyPolicy/OneForce.aspx")
                   let request = URLRequest(url:url!)
                   let webconfiguration  = WKWebViewConfiguration()
                          webview = WKWebView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), configuration: webconfiguration)
                   webview.load(request)
                   self.view.addSubview(webview)
            }
            else
            {
                    let alert = UIAlertController(title: "Error #A0090", message: "Internet Connection Failed" , preferredStyle : .alert)
                    alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                           switch action.style
                           {
                           case .default : break
                           case .cancel : break
                           case .destructive : break
                        }}))
                       self.present(alert,animated: true, completion: nil)
            }
            
            
        }
        
        else
        {
            if Reachability.isConnectedToNetwork()
            {
                   let url = URL(string : "https://www.myscanpay.com/v4/mobile/PrivacyPolicy/OneForce.aspx")
                   let request = URLRequest(url:url!)
                   let webconfiguration  = WKWebViewConfiguration()
                          webview = WKWebView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), configuration: webconfiguration)
                   webview.load(request)
                   self.view.addSubview(webview)
            }
            else
            {
                    let alert = UIAlertController(title: "Error #A0090", message: "Internet Connection Failed" , preferredStyle : .alert)
                    alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                           switch action.style
                           {
                           case .default : break
                           case .cancel : break
                           case .destructive : break
                           }}))
                       self.present(alert,animated: true, completion: nil)
            }
        }
        
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue:	 UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
