//
//  ViewController.swift
//  user
//
//  Created by Kek on 09/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate{
    

  
    
    @IBOutlet weak var phone_input: UITextField!
    
    @IBOutlet weak var phone_code: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var forgotpassword: UILabel!
    @IBOutlet weak var resetlogin_btn: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if ViewController.isJailbroken() == true
        {
           
            DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error #A0061", message: "MyScanPay,will not run on jailbreak/root device" , preferredStyle : .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                switch action.style{
                 
                case .default :
                    
                    exit(0);
                    
                    break
                    
                case .cancel : break
                    
                case .destructive : break
                
                }}))
            self.present(alert,animated: true, completion: nil)
            }
        }
        else
        {
            GetIOS_IndicatorTask()
          
                
                
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
           
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
                             
                self.addDoneButtonOnKeyboard()
            
            
                phone_code.isEnabled = false
                phone_input.delegate = self
                 phone_code.delegate = self
                 password.delegate = self
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
                
                forgotpassword.isUserInteractionEnabled = true
                forgotpassword.addGestureRecognizer(tap)
                
                let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.resetFunction))
                      
                      resetlogin_btn.isUserInteractionEnabled = true
                      resetlogin_btn.addGestureRecognizer(tap2)
               
                
             
                
                
                // let bottomLine3 = CALayer()
                // bottomLine3.frame = CGRect(origin: CGPoint(x: 0, y:phone_code.frame.height - 1), size: CGSize(width: phone_code.frame.width, height:  1))/
                //   bottomLine3.backgroundColor = UIColor.black.cgColor
               //  phone_code.borderStyle = UITextBorderStyle.none
               //  phone_code.layer.addSublayer(bottomLine3)
                
            

                
              
        }
        
     }
    func GetIOS_VersionTask()
    {
        var localversion = 0.00

        if Reachability.isConnectedToNetwork(){
                 if let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/ios-native-user-version.txt")
                 {
                   do {
                       let contents = try String(contentsOf: url2)
                  
                    let onlineversion = Double(contents) ?? 0.00
                    localversion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? Double ?? 0.00
                    
                   
                       
                    if (localversion < onlineversion)
                    {
                        DispatchQueue.main.async {
                                       let alert = UIAlertController(title: "Alert", message: "ScanPay have new latest app in apple apps store now" , preferredStyle : .alert)
                                           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                                                     
                                            if UserPreference.retreiveLoginID() != ""
                                                                       {
                                                                                                                         
                                                                           
                                                                               let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainpage") as! UIViewController
                                                                               nextViewController.modalPresentationStyle = .fullScreen
                                                                               self.present(nextViewController,animated:true,completion:nil)
                                                                           
                                                                                                                                
                                                                       }
                                          
                                           
                                           }))

                                           self.present(alert,animated: true, completion: nil)
                                                                                      
                                           }
                                       
                                       
                                   
                    }
                    else if (localversion >= onlineversion)
                    {
                        if UserPreference.retreiveLoginID() != ""
                        {
                                DispatchQueue.main.async {
                            
                                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainpage") as! UIViewController
                                nextViewController.modalPresentationStyle = .fullScreen
                                self.present(nextViewController,animated:true,completion:nil)
                            }
                            
                                                                                 
                        }
                    }
                   
                   }
                   catch {
                       
                   }
                   
                             // guard let requestUrl = url2 else { fatalError() }
                              // Prepare URL Request Object
                             // var request = URLRequest(url: requestUrl)
                             // request.httpMethod = "GET"
                               
                       
                              // Set HTTP Request Body
                              //request.httpBody = postString.data(using: String.Encoding.utf8);
                              // Perform HTTP Request
                            
                              
               }
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
    func GetIOS_IndicatorTask()
    {
        if Reachability.isConnectedToNetwork(){
          if let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/ios-native-user.txt")
          {
            do {
                let contents = try String(contentsOf: url2)
               
                
                if contents == "0"
                {
                            if UserPreference.retreiveLoginID() != ""
                            {
                                                                              
                                DispatchQueue.main.async {
                                    let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainpage") as! UIViewController
                                    nextViewController.modalPresentationStyle = .fullScreen
                                    self.present(nextViewController,animated:true,completion:nil)
                                }
                                                                                     
                            }
                                                               
              }
                else if contents == "1"
                {
                    GetIOS_VersionTask()
                                                               
                }
                else if contents == "2"
                {
                DispatchQueue.main.async {
                let alert = UIAlertController(title: "Alert", message: "Please update MyScanPay before proceed" , preferredStyle : .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                                            
                    alert.dismiss(animated:true, completion: nil)
                    exit(0);
                    }))

                    self.present(alert,animated: true, completion: nil)
                                                               
                    }
                
                
            }
            }
            catch {
                
            }
            
                      // guard let requestUrl = url2 else { fatalError() }
                       // Prepare URL Request Object
                      // var request = URLRequest(url: requestUrl)
                      // request.httpMethod = "GET"
                        
                
                       // Set HTTP Request Body
                       //request.httpBody = postString.data(using: String.Encoding.utf8);
                       // Perform HTTP Request
                     
                       
        }
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
    
    @objc
    func tapFunction(sender: UITapGestureRecognizer)
    {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "forgotpassword") as! UIViewController
  nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController,animated:true,completion:nil)
        
    }

      @objc
      func resetFunction(sender: UITapGestureRecognizer)
      {
          let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "resetstatus") as! UIViewController
    nextViewController.modalPresentationStyle = .fullScreen
          self.present(nextViewController,animated:true,completion:nil)
          
      }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
             self.view.endEditing(true)
             return false
         }
    
    
    func addDoneButtonOnKeyboard(){
           let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
           doneToolbar.barStyle = .default

           let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

           let items = [flexSpace, done]
           doneToolbar.items = items
           doneToolbar.sizeToFit()

           phone_input.inputAccessoryView = doneToolbar
         
           
       }

       @objc func doneButtonAction(){
           phone_input.resignFirstResponder()
           
       }
    @IBAction func intentmainpage(_ sender: UIButton) {
       
        if Reachability.isConnectedToNetwork(){
            let url = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostLogin_Validate_LoginID.aspx")
            guard let requestUrl = url else { fatalError() }
            // Prepare URL Request Object
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "POST"
             
              let phoneinput = (phone_code.text)! + (phone_input.text)!
              let passwordinput = (password.text)!
            // HTTP Request Parameters which will be sent in HTTP Request Body
              let postString = "LoginID=\(phoneinput)&Password=\(passwordinput)";
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
                     
                      if dataString == "Allow Login"
                      {
                          UserPreference.saveLoginID(loginid: (self.phone_code.text)! + (self.phone_input.text)!)
                          UserPreference.saveLoginPassword(loginpassword: (self.password.text)!)
                          
                          DispatchQueue.main.async {
                           let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainpage") as! UIViewController
                              nextViewController.modalPresentationStyle = .fullScreen
                          self.present(nextViewController,animated:true,completion:nil)
                          }
                      }
                      else if dataString == "Not Allow Login"
                      {
                           DispatchQueue.main.async {
                           let alert = UIAlertController(title: "Alert", message: "Your Account have been login by another device", preferredStyle: UIAlertControllerStyle.alert)
                          alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                          self.present(alert, animated: true, completion: nil)
                          }
                      }
                      else
                      {
                           DispatchQueue.main.async {
                          let alert = UIAlertController(title: "Alert", message: "\(dataString)", preferredStyle: UIAlertControllerStyle.alert)
                          alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
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

      
        
        
        
        
           // let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainpage") as! UIViewController

      //  present(nextViewController,animated:true,completion:nil)
        
    }
    @IBAction func intentsignup(_ sender: UIButton) {
         let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "signupstep1") as! UIViewController
        nextViewController.modalPresentationStyle = .fullScreen
               present(nextViewController,animated:true,completion:nil)
        
    }
    
   
    
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
    static func isJailbroken() -> Bool {

       

        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: "/Applications/Cydia.app") ||
            fileManager.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
            fileManager.fileExists(atPath: "/bin/bash") ||
            fileManager.fileExists(atPath: "/usr/sbin/sshd") ||
            fileManager.fileExists(atPath: "/etc/apt") ||
            fileManager.fileExists(atPath: "/usr/bin/ssh") {
            return true
        }

        if canOpen(path: "/Applications/Cydia.app") ||
            canOpen(path: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
            canOpen(path: "/bin/bash") ||
            canOpen(path: "/usr/sbin/sshd") ||
            canOpen(path: "/etc/apt") ||
            canOpen(path: "/usr/bin/ssh") {
            return true
        }

        let path = "/private/" + NSUUID().uuidString
        do {
            try "anyString".write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            try fileManager.removeItem(atPath: path)
            return true
        } catch {
            return false
        }
    }

    static func canOpen(path: String) -> Bool {
        let file = fopen(path, "r")
        guard file != nil else { return false }
        fclose(file)
        return true
    }
}



