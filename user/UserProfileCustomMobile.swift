//
//  UserProfileCustomMobile.swift
//  user
//
//  Created by Kek on 31/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class UserProfileCustomMobile: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var savebtn: UIButton!
    @IBOutlet weak var mobile_edit: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mobile_edit.delegate = self
       reloadpage()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func reloadpage()
    {
         if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/GetMyProfileList.aspx")
        guard let requestUrl = url2 else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
         
          let phoneinput = UserPreference.retreiveLoginID()
        // HTTP Request Parameters which will be sent in HTTP Request Body
          let postString = "LoginID=\(phoneinput)";
          print(postString)
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
         
                // Convert HTTP Response Data to a String
                if let data = data {
                   do {
                      let res = try JSONDecoder().decode(UserInformation.self, from: data)
                      DispatchQueue.main.async() {
                        var value = res.datarecords[0].ml_hpno ?? ""
                        let realString = String(value)
                        self.mobile_edit.text = realString
                                                        
                                        
                                                     
                      }
                      
                   } catch let error {
                      print(error)
                   }
                  
                }
        }
        task.resume()
        }
        else
         {
            let alert = UIAlertController(title: "Error #A0090", message: "Internet Connection Failed" , preferredStyle : .alert)
                       alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                       switch action.style{
                                                                  
                       case .default : break
                                                                     
                       case .cancel : break
                                                                     
                       case .destructive : break
                                                                 
                       }}))
                       self.present(alert,animated: true, completion: nil)
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
               self.view.endEditing(true)
               return false
           }
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated:true,completion:nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostUserProfile_MobileNumber.aspx")
                     guard let requestUrl = url2 else { fatalError() }
                     // Prepare URL Request Object
                     var request = URLRequest(url: requestUrl)
                     request.httpMethod = "POST"
                      
                       let phoneinput = UserPreference.retreiveLoginID()
                       let MobileNumber = mobile_edit.text
                      if let myString = MobileNumber {
                            let postString = "LoginID=\(phoneinput)&MobileNumber=\(myString)";
                      
                      // HTTP Request Parameters which will be sent in HTTP Request Body
                    
                       print(postString)
                     // Set HTTP Request Body
                     request.httpBody = postString.data(using: String.Encoding.utf8);
                     // Perform HTTP Request
              }
                     let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                             
                             // Check for Error
                             if let error = error {
                                 print("Error took place \(error)")
                                 return
                             }
                      
                             // Convert HTTP Response Data to a String
                            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                          print("Response data string:\n \(dataString)")
                              
                          if dataString == "SAVE PROFILE MOBILE NUMBER SUCCESS"
                          {
                              self.reloadpage()
                             
                              DispatchQueue.main.async {
                              let alert = UIAlertController(title: "Alert", message: "Your Mobile Number have been saved", preferredStyle: UIAlertControllerStyle.alert)
                                                      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                                                                                                                                                                                                      self.dismiss(animated: true, completion: nil)
                                             
                                                                                                                                                                               }))
                                                 self.present(alert, animated: true, completion: nil)
                            }
                              }
                               
                             }
                     }
                     task.resume()
        }
        else
        {
            let alert = UIAlertController(title: "Error #A0090", message: "Internet Connection Failed" , preferredStyle : .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
            switch action.style{
                                                       
            case .default : break
                                                          
            case .cancel : break
                                                          
            case .destructive : break
                                                      
            }}))
            self.present(alert,animated: true, completion: nil)
        }
                       
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 100
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

}
