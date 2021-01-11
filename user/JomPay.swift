//
//  JomPay.swift
//  user
//
//  Created by Kek on 27/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit
import WebKit
class JomPay: UIViewController,WKUIDelegate,WKNavigationDelegate {
    
var webview = WKWebView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        if UIDevice.current.hasTopNotch
        {
                   if Reachability.isConnectedToNetwork()
                   {
                        let url = URL(string : "https://www.myscanpay.com/v4/mobile_native_api/myjompay.aspx?LoginID=\(UserPreference.retreiveLoginID())")
                        let request = URLRequest(url:url!)
                        let webconfiguration  = WKWebViewConfiguration()
                        webview = WKWebView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), configuration: webconfiguration)
                        webview.navigationDelegate = self
                        webview.load(request)
                        self.view.addSubview(webview)
                   }
                   else
                   {
                        let alert = UIAlertController(title: "Error", message: "Internet Connection Failed" , preferredStyle : .alert)
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
                        let url = URL(string : "https://www.myscanpay.com/v4/mobile_native_api/myjompay.aspx?LoginID=\(UserPreference.retreiveLoginID())")
                        let request = URLRequest(url:url!)
                        let webconfiguration  = WKWebViewConfiguration()
                          webview = WKWebView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), configuration: webconfiguration)
                        webview.navigationDelegate = self
                        webview.load(request)
                        self.view.addSubview(webview)
                   }
                   else
                   {
                       let alert = UIAlertController(title: "Error", message: "Internet Connection Failed" , preferredStyle : .alert)
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
        // Do any additional setup after loading the view.
          
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated
        {
            
            if let url = navigationAction.request.url, UIApplication.shared.canOpenURL(url)
            {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                decisionHandler(.cancel)
                print(url)
            }
            else
            {
                decisionHandler(.allow)
            }
        }
        else
        {
            decisionHandler(.allow)
        }
    }



    @IBAction func back(_ sender: UIButton) {
         self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
