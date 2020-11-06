//
//  UserProfileCustomPin.swift
//  user
//
//  Created by Kek on 31/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class UserProfileCustomPin: UIViewController ,UITextFieldDelegate{
    
    
    @IBOutlet weak var save_btn: UIButton!
    @IBOutlet weak var otp1: UITextField!
    @IBOutlet weak var otp2: UITextField!
    @IBOutlet weak var otp3: UITextField!
    @IBOutlet weak var otp4: UITextField!
    @IBOutlet weak var otp5: UITextField!
    @IBOutlet weak var otp6: UITextField!
    @IBOutlet weak var showpassword1: UIButton!
    
    @IBOutlet weak var oldotp1: UITextField!
    @IBOutlet weak var oldotp2: UITextField!
    @IBOutlet weak var oldotp3: UITextField!
    @IBOutlet weak var oldotp4: UITextField!
    @IBOutlet weak var oldotp5: UITextField!
    @IBOutlet weak var oldotp6: UITextField!
    @IBOutlet weak var showpassword2: UIButton!
    
    @IBOutlet weak var forget_pin_btn: UIButton!
    var indicator = false;
    var indicator2 = false;
    var old_otp_result = "";
    var email = ""
    var name = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        save_btn.isEnabled = false
        
        otp1.delegate = self
        otp2.delegate = self
        otp3.delegate = self
        otp4.delegate = self
        otp5.delegate = self
        otp6.delegate = self
        otp1.isSecureTextEntry = true
        otp2.isSecureTextEntry = true
        otp3.isSecureTextEntry = true
        otp4.isSecureTextEntry = true
        otp5.isSecureTextEntry = true
        otp6.isSecureTextEntry = true
        
        oldotp1.delegate = self
        oldotp2.delegate = self
        oldotp3.delegate = self
        oldotp4.delegate = self
        oldotp5.delegate = self
        oldotp6.delegate = self
        oldotp1.isSecureTextEntry = true
        oldotp2.isSecureTextEntry = true
        oldotp3.isSecureTextEntry = true
        oldotp4.isSecureTextEntry = true
        oldotp5.isSecureTextEntry = true
        oldotp6.isSecureTextEntry = true
        // Do any additional setup after loading the view.
        self.addDoneButtonOnKeyboard()
        
        reloadpage()
    }
    
    
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        otp1.inputAccessoryView = doneToolbar
        otp2.inputAccessoryView = doneToolbar
        otp3.inputAccessoryView = doneToolbar
        otp4.inputAccessoryView = doneToolbar
        otp5.inputAccessoryView = doneToolbar
        otp6.inputAccessoryView = doneToolbar
        
               oldotp1.inputAccessoryView = doneToolbar
               oldotp2.inputAccessoryView = doneToolbar
               oldotp3.inputAccessoryView = doneToolbar
               oldotp4.inputAccessoryView = doneToolbar
               oldotp5.inputAccessoryView = doneToolbar
               oldotp6.inputAccessoryView = doneToolbar
        
    }
    @objc func doneButtonAction(){
          otp1.resignFirstResponder()
          otp2.resignFirstResponder()
          otp3.resignFirstResponder()
          otp4.resignFirstResponder()
          otp5.resignFirstResponder()
          otp6.resignFirstResponder()
                oldotp1.resignFirstResponder()
                 oldotp2.resignFirstResponder()
                 oldotp3.resignFirstResponder()
                 oldotp4.resignFirstResponder()
                 oldotp5.resignFirstResponder()
                 oldotp6.resignFirstResponder()
      }
    
    @IBAction func otp1(_ sender: UITextField) {
        let x : Int? = sender.text?.count
               if  x! == 1
               {
                 checkallinformation()
                   otp2.becomeFirstResponder()
               }
               else
               {
                    
                   
               }
               checkMaxLength(textField: sender as! UITextField, maxLength: 1)
    }
    
    @IBAction func otp2(_ sender: UITextField) {
        let x : Int? = sender.text?.count
               if  x! == 1
               {
                 checkallinformation()
                   otp3.becomeFirstResponder()
               }
               else
               {
                    
                   
               }
               checkMaxLength(textField: sender as! UITextField, maxLength: 1)
    }
    @IBAction func otp3(_ sender: UITextField) {
        let x : Int? = sender.text?.count
               if  x! == 1
               {
                 checkallinformation()
                   otp4.becomeFirstResponder()
               }
               else
               {
                    
                   
               }
               checkMaxLength(textField: sender as! UITextField, maxLength: 1)
    }
    @IBAction func otp4(_ sender: UITextField) {
        let x : Int? = sender.text?.count
               if  x! == 1
               {
                 checkallinformation()
                   otp5.becomeFirstResponder()
               }
               else
               {
                    
                   
               }
               checkMaxLength(textField: sender as! UITextField, maxLength: 1)
    }
    @IBAction func otp5(_ sender: UITextField) {
       let x : Int? = sender.text?.count
        if  x! == 1
        {
          checkallinformation()
            otp6.becomeFirstResponder()
        }
        else
        {
             
            
        }
        checkMaxLength(textField: sender as! UITextField, maxLength: 1)
    }
    @IBAction func otp6(_ sender: UITextField) {
       let x : Int? = sender.text?.count
        if  x! == 1
        {
          checkallinformation()
           
        }
        else
        {
             
            
        }
        checkMaxLength(textField: sender as! UITextField, maxLength: 1)
        
    }
    
    @IBAction func showpassword1(_ sender: UIButton) {
        if(indicator == false) {
           otp1.isSecureTextEntry = false
           otp2.isSecureTextEntry = false
           otp3.isSecureTextEntry = false
           otp4.isSecureTextEntry = false
           otp5.isSecureTextEntry = false
           otp6.isSecureTextEntry = false
           
           showpassword1.setImage(UIImage(named: "eye_open"), for: .normal)
           indicator = true
             
        }
        else
        
        {
           otp1.isSecureTextEntry = true
           otp2.isSecureTextEntry = true
           otp3.isSecureTextEntry = true
           otp4.isSecureTextEntry = true
           otp5.isSecureTextEntry = true
           otp6.isSecureTextEntry = true
           indicator = false
           
           
           showpassword1.setImage(UIImage(named: "eye_close"), for: .normal)
           
           
              }
        
    }
    
    @IBAction func oldotp1(_ sender: UITextField) {
        let x : Int? = sender.text?.count
               if  x! == 1
               {
                 checkallinformation()
                   oldotp2.becomeFirstResponder()
               }
               else
               {
                    
                   
               }
               checkMaxLength(textField: sender as! UITextField, maxLength: 1)
    }
    
    @IBAction func oldotp2(_ sender: UITextField) {
        
        let x : Int? = sender.text?.count
               if  x! == 1
               {
                 checkallinformation()
                   oldotp3.becomeFirstResponder()
               }
               else
               {
                    
                   
               }
               checkMaxLength(textField: sender as! UITextField, maxLength: 1)
    }
    @IBAction func oldotp3(_ sender: UITextField) {
        
        let x : Int? = sender.text?.count
              if  x! == 1
              {
                checkallinformation()
                  oldotp4.becomeFirstResponder()
              }
              else
              {
                   
                  
              }
        checkMaxLength(textField: sender as! UITextField, maxLength: 1)
    }
    @IBAction func oldotp4(_ sender: UITextField) {
      let x : Int? = sender.text?.count
        if  x! == 1
        {
          checkallinformation()
            oldotp5.becomeFirstResponder()
        }
        else
        {
             
            
        }
        checkMaxLength(textField: sender as! UITextField, maxLength: 1)
        
    }
    @IBAction func oldotp5(_ sender: UITextField) {
        
        let x : Int? = sender.text?.count
               if  x! == 1
               {
                 checkallinformation()
                   oldotp6.becomeFirstResponder()
               }
               else
               {
                    
                   
               }
      checkMaxLength(textField: sender as! UITextField, maxLength: 1)
    }
    @IBAction func oldotp6(_ sender: UITextField) {
        let x : Int? = sender.text?.count
               if  x! == 1
               {
                 checkallinformation()
                  
               }
               else
               {
                    
                   
               }
     checkMaxLength(textField: sender as! UITextField, maxLength: 1)
    }
    
    @IBAction func showpassword2(_ sender: UIButton) {
        
        if(indicator2 == false) {
           oldotp1.isSecureTextEntry = false
           oldotp2.isSecureTextEntry = false
           oldotp3.isSecureTextEntry = false
           oldotp4.isSecureTextEntry = false
           oldotp5.isSecureTextEntry = false
           oldotp6.isSecureTextEntry = false
           
           showpassword2.setImage(UIImage(named: "eye_open"), for: .normal)
           indicator2 = true
             
        }
        else
        
        {
           oldotp1.isSecureTextEntry = true
           oldotp2.isSecureTextEntry = true
           oldotp3.isSecureTextEntry = true
           oldotp4.isSecureTextEntry = true
           oldotp5.isSecureTextEntry = true
           oldotp6.isSecureTextEntry = true
           indicator2 = false
           
           
           showpassword2.setImage(UIImage(named: "eye_close"), for: .normal)
           
           
              }
        
        
    }
    
    func reloadpage()
          {
            if Reachability.isConnectedToNetwork(){
              let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/GetMyProfileList.aspx")
                     guard let requestUrl = url2 else { fatalError() }
                     // Prepare URL Request Object
                     var request = URLRequest(url: requestUrl)
                     request.httpMethod = "POST"
                      
                let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
                
                  let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
                
                let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                
                
                       let phoneinput = UserPreference.retreiveLoginID()
                     // HTTP Request Parameters which will be sent in HTTP Request Body
                       let postString = "LoginID=\(phoneinput)&Token=\(postStringencoding ?? "")";
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
                                    self.name = res.datarecords[0].ml_Name ?? ""
                                    self.email = res.datarecords[0].ml_email ?? ""
                                    self.old_otp_result
                                        = res.datarecords[0].ml_paymentpin ?? ""
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
    
    @IBAction func save(_ sender: UIButton) {
        if !(oldotp1.text!.isEmpty) && !(oldotp2.text!.isEmpty) && !(oldotp3.text!.isEmpty) && !(oldotp4.text!.isEmpty) && !(oldotp5.text!.isEmpty) && !(oldotp6.text!.isEmpty)
                       {
                            let str = "\(oldotp1.text!)\(oldotp2.text!)\(oldotp3.text!)\(oldotp4.text!)\(oldotp5.text!)\(oldotp6.text!)"
                          
                          if old_otp_result == str
                          {
                              if !(otp1.text!.isEmpty) && !(otp2.text!.isEmpty) && !(otp3.text!.isEmpty) && !(otp4.text!.isEmpty) && !(otp5.text!.isEmpty) && !(otp6.text!.isEmpty)
                               {
                                self.savepin()
                               }
                               else
                              {
                                let alert = UIAlertController(title: "Alert ", message: "New OTP empty" , preferredStyle : .alert)
                               
                                alert.addAction(UIAlertAction(title:"Cancel", style: .default ,handler:{(action: UIAlertAction!) in
                                    
                                }))
                                self.present(alert,animated: true, completion: nil)
                                print("new otp empty")
                               }
                           }
                           else
                          {
                            let alert = UIAlertController(title: "Alert ", message: "Old OTP not match with system" , preferredStyle : .alert)
                                                          
                                                           alert.addAction(UIAlertAction(title:"Cancel", style: .default ,handler:{(action: UIAlertAction!) in
                                                               
                                                           }))
                                                           self.present(alert,animated: true, completion: nil)
                           print("old otp not match")
                           }
                               
                           
                       }
                       else
                          {
                            let alert = UIAlertController(title: "Alert ", message: "Old OTP Empty" , preferredStyle : .alert)
                                                                                     
                                                                                      alert.addAction(UIAlertAction(title:"Cancel", style: .default ,handler:{(action: UIAlertAction!) in
                                                                                          
                                                                                      }))
                                                                                      self.present(alert,animated: true, completion: nil)
                              print("old otp empty")
                              
                          }
               
                              
        
    }
    func savepin()
    {
         if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostUserProfile_Pin.aspx")
                            guard let requestUrl = url2 else { fatalError() }
                            // Prepare URL Request Object
                            var request = URLRequest(url: requestUrl)
                            request.httpMethod = "POST"
            
                     let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
            
             let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
            
             let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            
            let str = "\(otp1.text!)\(otp2.text!)\(otp3.text!)\(otp4.text!)\(otp5.text!)\(otp6.text!)"
        
        
        
                              let phoneinput = UserPreference.retreiveLoginID()
                             
                             
                                   let postString = "LoginID=\(phoneinput)&PIN=\(str)&Token=\(postStringencoding ?? "")";
                             
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
                                     
                                 if dataString == "SAVE PROFILE PIN PAYMENT SUCCESS"
                                 {
                                     DispatchQueue.main.async {
                                     self.reloadpage()
                                    
                                     let alert = UIAlertController(title: "Alert", message: "Your Pin Payment have been saved", preferredStyle: UIAlertControllerStyle.alert)
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
    func sendforget_pin()
    {
         if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/Recover_Pin.aspx")
                            guard let requestUrl = url2 else { fatalError() }
                            // Prepare URL Request Object
                            var request = URLRequest(url: requestUrl)
                            request.httpMethod = "POST"
             let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
            
            let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
             
            
            let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                            // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "Pin_Number=\(self.old_otp_result)&Email=\(self.email)&Name=\(self.name)&Token=\(postStringencoding ?? "")";
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
                                      
                                DispatchQueue.main.async()
                                  {
                                if dataString == "Recovery Pin Success"
                                {
                                    
                                    let alert = UIAlertController(title: "Alert ", message: "Recovery Pin password sent, Please check email" , preferredStyle : .alert)
                                    alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{(action: UIAlertAction!) in
                                        
                                        self.forget_pin_btn.isEnabled = true
                                        
                                    }))
                                    self.present(alert,animated: true, completion: nil)
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
    
    @IBAction func forget_pin(_ sender: UIButton) {
        let alert = UIAlertController(title: "Alert ", message: "Press confirm send Pin Password to your email" , preferredStyle : .alert)
        alert.addAction(UIAlertAction(title:"Confirm", style: .default ,handler:{(action: UIAlertAction!) in
            self.forget_pin_btn.isEnabled = false
            self.sendforget_pin()
            
        }))
        alert.addAction(UIAlertAction(title:"Cancel", style: .default ,handler:{(action: UIAlertAction!) in
            
        }))
        self.present(alert,animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    private func checkallinformation()
    {
        
        save_btn.isEnabled = true
           
       
    }
    
    
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated:true,completion:nil)
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                print("Backspace was pressed")
            }
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           
    
        
        
           let allowedCharacters = "0123456789"
           let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
           let typedCharacterSet = CharacterSet(charactersIn: string)
           
           return allowedCharacterSet.isSuperset(of: typedCharacterSet)
       }
         func textFieldShouldReturn(_ textField: UITextField) -> Bool {
             self.view.endEditing(true)
             return false
         }

func checkMaxLength(textField: UITextField!, maxLength: Int) {
         // swift 1.0
         //if (count(textField.text!) > maxLength) {
         //    textField.deleteBackward()
         //}
         // swift 2.0
         if (textField.text!.characters.count > maxLength) {
             textField.deleteBackward()
         }
     }


 
 
    
   

}



