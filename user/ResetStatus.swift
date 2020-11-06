//
//  ResetStatus.swift
//  user
//
//  Created by Kek on 24/06/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class ResetStatus: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var loginid: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var OTP: UITextField!
    
    @IBOutlet weak var sendotp_btn: UIButton!
    
    @IBOutlet weak var reset_btn: UIButton!
    
    var systemotp = ""
    
    var timer: Timer?
    var totalTime = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginid.delegate = self
        email.delegate = self
        OTP.delegate = self
        
        reset_btn.isHidden = true
        // Do any additional setup after loading the view.
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
                       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
               
        self.addDoneButtonOnKeyboard()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer)
       {
           loginid.resignFirstResponder()
           email.resignFirstResponder()
           OTP.resignFirstResponder()
          
           
       }
    @IBAction func logininsert(_ sender: UITextField) {
    }
    
    @IBAction func emailinsert(_ sender: UITextField) {
    }
    
    
    @IBAction func otpinsert(_ sender: UITextField) {
        
        let x : Int? = sender.text?.count
               if  sender.text!.count > 0
                  {
                       if systemotp == OTP.text
                       {
                           reset_btn.isHidden = false
                       }
                   else
                       {
                            reset_btn.isHidden = true
                       }
                  }
               else
                  {
                    reset_btn.isHidden = true
                   
                  }
               
        
    }
    

    
    @IBAction func sendotp_btn(_ sender: UIButton) {
        if loginid.text == "" || email.text == ""
        {
            let alert = UIAlertController(title: "Error #A0051", message: "Loginid and email cant be empty" , preferredStyle : .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                switch action.style{
                 
                case .default : break
                    
                case .cancel : break
                    
                case .destructive : break
                
                }}))
            self.present(alert,animated: true, completion: nil)
        }
        else
        {
            validateloginID()
        }
        
    }
    
    
    @IBAction func reset(_ sender: UIButton) {
        
        saveotptask()
    }
    
    @IBAction func back(_ sender: UIButton) {
         self.dismiss(animated: true, completion: nil) 
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

              loginid.inputAccessoryView = doneToolbar
            
              
          }

          @objc func doneButtonAction(){
              loginid.resignFirstResponder()
              
          }
    
    func validateloginID()
    {
         if Reachability.isConnectedToNetwork(){
        let url = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostVerification_Validate_LoginID.aspx")
            guard let requestUrl = url else { fatalError() }
            // Prepare URL Request Object
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "POST"
             
            
                  let value =  "s7OyGTP6ZZmL7t3z"
                                                     
                                                     
                  let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
                                      
                  let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            
              let phoneinput = "60" + (loginid.text)!
             
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
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        print("Response data string:\n \(dataString)")
                     
                      if dataString == "This Login allow"
                      {
                        
                        self.validateemailtask()
                          DispatchQueue.main.async {
                            
                        }
                         
                      }
                      else if dataString == "This Login ID not available"
                      {
                           DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Error #A0052", message: "This Login ID not available " , preferredStyle : .alert)
                            alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                                switch action.style{
                                 
                                case .default : break
                                    
                                case .cancel : break
                                    
                                case .destructive : break
                                
                                }}))
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
    
    func validateemailtask()
    {
        if Reachability.isConnectedToNetwork(){
        let url = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostVerification_Validate_Email.aspx")
                   guard let requestUrl = url else { fatalError() }
                   // Prepare URL Request Object
                   var request = URLRequest(url: requestUrl)
                   request.httpMethod = "POST"
                  
            let value =  "s7OyGTP6ZZmL7t3z"
                                             
                                             
          let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
                              
          let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            
                     let emailinput =  (email.text)!
                    
                   // HTTP Request Parameters which will be sent in HTTP Request Body
                     let postString = "Email=\(emailinput)";
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
                            
                             if dataString == "This Email allow"
                             {
                               
                                self.sendotptask()
                                 DispatchQueue.main.async {
                                   
                               }
                                
                             }
                             else if dataString == "This Email not available"
                             {
                                  DispatchQueue.main.async {
                                   let alert = UIAlertController(title: "Error #A0053", message: "This Email not available " , preferredStyle : .alert)
                                   alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                                       switch action.style{
                                        
                                       case .default : break
                                           
                                       case .cancel : break
                                           
                                       case .destructive : break
                                       
                                       }}))
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
    
    func sendotptask()
    {
        if Reachability.isConnectedToNetwork(){
        let url = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostVerification_Send_OTP.aspx")
                   guard let requestUrl = url else { fatalError() }
                   // Prepare URL Request Object
                   var request = URLRequest(url: requestUrl)
                   request.httpMethod = "POST"
                    
                    let value =  "s7OyGTP6ZZmL7t3z"
                                                       
                                                       
                    let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
                                        
                    let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            
                     let phoneinput = "60" + (loginid.text)!
                    
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
                           if let data = data, let dataString = String(data: data, encoding: .utf8) {
                               print("Response data string:\n \(dataString)")
                            
                             DispatchQueue.main.async {
                            self.systemotp = dataString
                            self.startOtpTimer()
                             
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
    func saveotptask()
    {
        if Reachability.isConnectedToNetwork(){
        let url = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostVerification_Save_OTP.aspx")
                          guard let requestUrl = url else { fatalError() }
                          // Prepare URL Request Object
                          var request = URLRequest(url: requestUrl)
                          request.httpMethod = "POST"
                    
            let value =  "s7OyGTP6ZZmL7t3z"
                                                    
            let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
                                                 
            let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            
            
                            let phoneinput = "60" + (loginid.text)!
                           
                          // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "LoginID=\(phoneinput)&OTP=\(self.OTP.text ?? "")&Token=\(postStringencoding ?? "")";
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
                                   if dataString == "SAVE OTP BACKEND SYSTEM SUCCESS"
                                   {
                                    
                                    DispatchQueue.main.async {
                                                                    
                                                                       let alert = UIAlertController(title: "Alert", message: "Reset Login Complete" , preferredStyle : .alert)
                                                                                                         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                                                                                                            self.dismiss(animated: true, completion: nil)
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
    
    private func startOtpTimer() {
               self.timer?.invalidate()
               self.totalTime = 30
                          self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
                 }
       @objc func updateTimer()
       {
           sendotp_btn.isEnabled=false
           let myString = String(self.totalTime);
           self.sendotp_btn.setTitle(myString, for: .normal) // will show timer
          if totalTime != 0
          {
               totalTime -= 1  // decrease counter timer
           } else
          {
               if let timer = self.timer
               {
                 timer.invalidate()
                 self.timer = nil
                    self.sendotp_btn.setTitle("Resend", for: .normal)
                          sendotp_btn.isEnabled=true
                   self.totalTime = 0
                   
           }
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
                  self.view.frame.origin.y -= 150
              }
          }
      }

      @objc func keyboardWillHide(notification: NSNotification) {
          if self.view.frame.origin.y != 0 {
              self.view.frame.origin.y = 0
          }
      }
}
