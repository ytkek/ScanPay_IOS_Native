//
//  UserProfileCustomAppPassword.swift
//  user
//
//  Created by Kek on 31/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class UserProfileCustomAppPassword: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var newpassword: UITextField!
    @IBOutlet weak var oldpassword: UITextField!
    @IBOutlet weak var savebtn: UIButton!
    var oldpasswordresult = "";
    override func viewDidLoad() {
        super.viewDidLoad()
            getoldpassword()
        savebtn.isEnabled = false
        // Do any additional setup after loading the view.
        newpassword.delegate = self;
        oldpassword.delegate = self;
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
              NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
    func getoldpassword()
    {
        if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostUserProfile_OldPassword.aspx")
                      guard let requestUrl = url2 else { fatalError() }
                      // Prepare URL Request Object
                      var request = URLRequest(url: requestUrl)
                      request.httpMethod = "POST"
            
             let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
            
            let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
            
             let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                              
            
                       
                        let phoneinput = UserPreference.retreiveLoginID()
                       
                  
                             let postString = "Token=\(postStringencoding ?? "")&LoginID=\(phoneinput)";
                       
                       // HTTP Request Parameters which will be sent in HTTP Request Body
                     
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
                             if let data = data, let dataString = String(data: data, encoding: .utf8) {
                           print("Response data string:\n \(dataString)")
                                self.oldpasswordresult = dataString
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
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated:true,completion:nil)
    }
    
    @IBAction func newpasswordchanged(_ sender: UITextField) {
        savebtn.isEnabled = true
    }
    @IBAction func oldpasswordchanged(_ sender: UITextField) {
       savebtn.isEnabled = true
    }
    
    func savepassword()
    {
        if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostUserProfile_NewPassword.aspx")
                      guard let requestUrl = url2 else { fatalError() }
                      // Prepare URL Request Object
                      var request = URLRequest(url: requestUrl)
                      request.httpMethod = "POST"
            
            
                      let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
            
              let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
            
              let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                       
                        let phoneinput = UserPreference.retreiveLoginID()
                       
               let newpasswordstring = newpassword.text
                        if let myString = newpasswordstring {
                           let postString = "LoginID=\(phoneinput)&NewPassword=\(myString)&Token=\(postStringencoding ?? "")";
                                 
                                 // HTTP Request Parameters which will be sent in HTTP Request Body
                               
                                  print(postString)
                                // Set HTTP Request Body
                                request.httpBody = postString.data(using: String.Encoding.utf8);
                                // Perform HTTP Request
                         }
                            
                      // Perform HTTP Request
               
                      let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                              
                              // Check for Error
                              if let error = error {
                                  print("Error took place \(error)")
                                  return
                              }
                       
                              // Convert HTTP Response Data to a String
                             if let data = data, let dataString = String(data: data, encoding: .utf8) {
                           print("Response data string:\n \(dataString)")
                               
                               if dataString == "SAVE PROFILE PASSWORD SUCCESS"
                               {
                                   DispatchQueue.main.async {
                                    
                                    UserPreference.removeLoginPassword()
                                    UserPreference.saveLoginPassword(loginpassword: self.newpassword.text ?? "")
                                   
                                      let alert = UIAlertController(title: "Alert", message: "Your Password have been changed", preferredStyle: UIAlertControllerStyle.alert)
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
    
    
    @IBAction func save(_ sender: UIButton) {
       if oldpassword.text == self.oldpasswordresult
              {
                if newpassword.text?.count ?? 0 >= 4 && newpassword.text?.isAlphanumeric ?? false
                {
                    self.savepassword()
                }
                else
                {
                    let alert = UIAlertController(title: "Error #A0005", message: "At least 4 char and Alphanumeric" , preferredStyle : .alert)
                               alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                                   switch action.style{
                                    
                                   case .default : break
                                       
                                   case .cancel : break
                                       
                                   case .destructive : break
                                   
                                   }}))
                               self.present(alert,animated: true, completion: nil)
                
                
                 
               }
                  
              }
       else
       {
           let alert = UIAlertController(title: "Alert ", message: "Old Password not match with system" , preferredStyle : .alert)
           
            alert.addAction(UIAlertAction(title:"Cancel", style: .default ,handler:{(action: UIAlertAction!) in
                
            }))
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
