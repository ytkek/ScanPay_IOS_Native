//
//  SettingTable.swift
//  user
//
//  Created by Kek on 13/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Firebase

class SettingTable: UITableViewController
{

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
      
    }
    
    @IBAction func logout(_ sender: UIButton)
    {
        let url = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostLogout_Update_Status.aspx")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let value =  "s7OyGTP6ZZmL7t3z"
        let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
        let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        let phoneinput = UserPreference.retreiveLoginID()
        let postString = "LoginID=\(phoneinput)&Token=\(postStringencoding ?? "")";
          print(postString)
        request.httpBody = postString.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error
        {
            print("Error took place \(error)")
            return
        }
        if let data = data, let dataString = String(data: data, encoding: .utf8)
        {
                    print("Response data string:\n \(dataString)")
                
            if dataString == "Update Logout Success"
            {
                    UserPreference.removeLoginID()
                    UserPreference.removeLoginPassword()
                    DispatchQueue.main.async
                    {
                         Messaging.messaging().unsubscribe(fromTopic: UserPreference.retreiveLoginID() ?? "")
                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "viewcontroller") as! UIViewController
                        nextViewController.modalPresentationStyle = .fullScreen
                        self.present(nextViewController,animated:true,completion:nil)
                         
                    }
              }
                 
                  
            }
        }
        task.resume()
        
    }
    @IBAction func profileintent(_ sender: UIButton)
    {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "userprofile") as! UIViewController
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController,animated:true,completion:nil)
    }
    
    @IBAction func messageintent(_ sender: UIButton)
    {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "messagecenter") as! UIViewController
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController,animated:true,completion:nil)
        
    }
    @IBAction func aboutusintent(_ sender: UIButton)
    {
        
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "aboutus") as! UIViewController
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController,animated:true,completion:nil)
    }
    @IBAction func locationintent(_ sender: UIButton) {
        
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "location") as! UIViewController
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController,animated:true,completion:nil)
    }
    @IBAction func systeminfointent(_ sender: UIButton) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "systeminfo") as! UIViewController
            nextViewController.modalPresentationStyle = .fullScreen
            present(nextViewController,animated:true,completion:nil)
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        {
            var cellHeight:CGFloat = CGFloat()
                cellHeight = UIScreen.main.bounds.height
                
            return cellHeight
        }
        
         override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                // #warning Incomplete implementation, return the number of rows
                return 1
            }

            
            override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "settingcell", for: indexPath) as! SettingCell
                cell.selectionStyle = .none
              

                return cell
            }
           
        }



    extension SettingTable: IndicatorInfoProvider{
           func indicatorInfo(for pagerTabStripController : PagerTabStripViewController) ->
               IndicatorInfo{
                   return IndicatorInfo(image: UIImage(named : "setting"))
               }
           
           }



