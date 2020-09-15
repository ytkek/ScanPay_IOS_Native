//
//  ScanPayQRCode.swift
//  user
//
//  Created by Kek on 25/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit
import BarcodeScanner
import Foundation

class ScanPayQRCode: UIViewController,UITextFieldDelegate {
 var indicator = false;
    var indicator2 = "YES";
    
    
    @IBOutlet var qrpay_VIew: UIView!
    @IBOutlet weak var checkotp1: UIView!
    @IBOutlet weak var checkotp2: UIView!
    @IBOutlet weak var setnewotp: UIView!
    @IBOutlet weak var payment: UIView!
    @IBOutlet weak var error_message: UIView!
    
    @IBOutlet weak var payment_success: UIView!
    
    @IBOutlet weak var payment_success_amount: UILabel!
    
    @IBOutlet weak var payment_success_date: UILabel!
    
    @IBOutlet weak var payment_success_merchant: UILabel!
    
    
    @IBOutlet weak var getnewotp: UIButton!
    @IBOutlet weak var resend_btn: UIButton!
    @IBOutlet weak var enter_newotp: UITextField!
    @IBOutlet weak var confirm_newotp: UIButton!
    @IBOutlet weak var mobile_id: UILabel!
    
    @IBOutlet weak var user_spend: UILabel!
    @IBOutlet weak var merchant_name: UILabel!
    var merchant_name_single = ""
    @IBOutlet weak var error_message_label: UILabel!
    @IBOutlet weak var amount: UITextField!
    
    @IBOutlet weak var pin1: UITextField!
    @IBOutlet weak var pin2: UITextField!
    @IBOutlet weak var pin3: UITextField!
    @IBOutlet weak var pin4: UITextField!
    @IBOutlet weak var pin5: UITextField!
    @IBOutlet weak var pin6: UITextField!
    @IBOutlet weak var change_password: UIButton!
    
    
    @IBOutlet weak var confirm_btn: UIButton!
    
   
    var timer: Timer?
    var totalTime = 30
    
    var result_otp = ""
    var type = ""
    var merchantid = ""
    var qr_amount = ""
    var lqrcode = ""
    var qrcode = ""
    
    
    var monthexp = ""
    var dailyexp = ""
    var creditbalance = ""
    var qramount = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         if UIDevice.current.hasTopNotch
         {
            self.payment.frame.origin.y += 50
            self.checkotp1.frame.origin.y += 50
            self.checkotp2.frame.origin.y += 50
            self.setnewotp.frame.origin.y += 50
            self.error_message.frame.origin.y += 50
            self.payment_success.frame.origin.y += 50
            self.getnewotp.frame.origin.y += 50
        }
        else
         {
            
        }
        pin1.delegate = self
        pin2.delegate = self
        pin3.delegate = self
        pin4.delegate = self
        pin5.delegate = self
        pin6.delegate = self
        pin1.isSecureTextEntry = true
        pin2.isSecureTextEntry = true
        pin3.isSecureTextEntry = true
        pin4.isSecureTextEntry = true
        pin5.isSecureTextEntry = true
        pin6.isSecureTextEntry = true
        checkotp1.isHidden = true
        checkotp2.isHidden = true
        getnewotp.isHidden = true
        
        setnewotp.isHidden = true
        confirm_newotp.isHidden = true
        payment.isHidden = true
        error_message.isHidden = true
        error_message_label.isHidden = true
        enter_newotp.delegate = self
        //amount.delegate = self
        
        
        confirm_btn.isEnabled = false
        
      
        
        payment_success.isHidden = true
        self.addDoneButtonOnKeyboard()
    }
    
    @IBAction func done_amount(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func payment_success_close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
    @IBAction func confirm_pay(_ sender: UIButton) {
        
        if self.amount.text == ""
        {
            let alert = UIAlertController(title: "Error #A0039 ", message: "Amount Can't be empty" , preferredStyle : .alert)
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
            self.qramount = self.amount.text ?? ""
            validate_pinnumber()
        }
        
    }
    func comfirm_pay_task()
    {
         if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostPay_Confirm_Pay.aspx")
                                                  guard let requestUrl = url2 else { fatalError() }
                                                  // Prepare URL Request Object
                                                  var request = URLRequest(url: requestUrl)
                                                  request.httpMethod = "POST"
                                                  
            let postString = "LoginID=\(UserPreference.retreiveLoginID())&MerchantID=\(self.merchantid)&MerchantName=\(self.merchant_name_single)&type=\(self.type)&Amount=\(self.amount.text ?? "")&qrcode=\(self.qrcode)&dyqrcode=\(self.lqrcode)";
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
                                                       self.app_success_message_log(success_message: "success payment \(self.lqrcode ?? "")\(self.qrcode ?? "")")
                                                        self.payment_success.isHidden = false
                                                        self.payment_success_amount.text = "Amount:  \(self.amount.text ?? "")"
                                                        var currentDateTime = Date()
                                                        let dateFormatter = DateFormatter()
                                                        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
                                                        
                                                        let result = dateFormatter.string(from:currentDateTime)
                                                        
                                                        self.payment_success_date.text = result
                                                        self.payment_success_merchant.text = self.merchant_name_single
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
    func app_error_message_log(error_message : String?)
    {
        if Reachability.isConnectedToNetwork(){
               let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostApp_Error_Message.aspx")
                                                         guard let requestUrl = url2 else { fatalError() }
                                                         // Prepare URL Request Object
                                                         var request = URLRequest(url: requestUrl)
                                                         request.httpMethod = "POST"
                                                         
                   let postString = "LoginID=\(UserPreference.retreiveLoginID())&Message=\(error_message ?? "")";
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
    func app_success_message_log(success_message : String?)
       {
           if Reachability.isConnectedToNetwork(){
                  let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostApp_Success_Message.aspx")
                                                            guard let requestUrl = url2 else { fatalError() }
                                                            // Prepare URL Request Object
                                                            var request = URLRequest(url: requestUrl)
                                                            request.httpMethod = "POST"
                                                            
                      let postString = "LoginID=\(UserPreference.retreiveLoginID())&Message=\(success_message ?? "")";
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
    func validate_pinnumber()
    {
         if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostPay_Validate_PinNumber.aspx")
                                    guard let requestUrl = url2 else { fatalError() }
                                    // Prepare URL Request Object
                                    var request = URLRequest(url: requestUrl)
                                    request.httpMethod = "POST"
                                
                                      let phoneinput = UserPreference.retreiveLoginID()
let pinnum = "\(self.pin1.text ?? "")\(self.pin2.text ?? "")\(self.pin3.text ?? "")\(self.pin4.text ?? "")\(self.pin5.text ?? "")\(self.pin6.text ?? "")"
                                    // HTTP Request Parameters which will be sent in HTTP Request Body
        print (pinnum)
      //   if let myString = pinnum {
                                      let postString = "LoginID=\(phoneinput)&Pin_Number=\(pinnum)";
                                    // Set HTTP Request Body
                                    request.httpBody = postString.data(using: String.Encoding.utf8);
                                    // Perform HTTP Request
       // }
                                    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                                            
                                            // Check for Error
                                            if let error = error {
                                                print("Error took place \(error)")
                                                return
                                            }
                                     
                                            // Convert HTTP Response Data to a String
                                            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                                            print("Response data string:\n \(dataString)")
                                             let result = dataString
                                              
                                            
                                             DispatchQueue.main.async(){
                                                if result == "Valid Pin Number"
                                                {
                                                   
                                                    
                                                    if  let b = Double(self.amount.text ?? "") , let a = Double(self.creditbalance), b>a
                                                    {
                                                       
                                                        let alert = UIAlertController(title: "Error #A0035", message: "Not Enough Credit" , preferredStyle : .alert)
                                                                                                          
                                                        alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                                                                                                               switch action.style{
                                                                                                                
                                                                                                               case .default :
                                                                                                                self.app_error_message_log(error_message: "unsuccessful payment Error #A0035 Not Enough Credit");                                       break
                                                                                                                   
                                                                                                               case .cancel : break
                                                                                                                   
                                                                                                               case .destructive : break
                                                                                                               
                                                                                                               }}))
                                                                                                           self.present(alert,animated: true, completion: nil)
                                                    }
                                                    else if let b = Double(self.amount.text ?? ""),let c = Double(self.dailyexp), b > c
                                                    {
                                                       
                                                        let alert = UIAlertController(title: "Error #A0036", message: "Not allow to exceed daily limit" , preferredStyle : .alert)
                                                        alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                                                            switch action.style{
                                                             
                                                            case .default :
                                                                 self.app_error_message_log(error_message: "unsuccessful payment Error #A0036 Not allow to exceed daily limit")
                                                                
                                                                break
                                                                
                                                            case .cancel : break
                                                               
                                                            case .destructive : break
                                                            
                                                            }}))
                                                        self.present(alert,animated: true, completion: nil)
                                                    }
                                                    else if let b = Double(self.amount.text ?? ""),b > 200.00
                                                    {
                                                       
                                                        let alert = UIAlertController(title: "Error #A0037", message: "Not allow to exceed purse limit" , preferredStyle : .alert)
                                                        alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                                                            switch action.style{
                                                             
                                                            case .default :
                                                                 self.app_error_message_log(error_message: "unsuccessful payment  Error #A0037 Not allow to exceed purse limit")
                                                                break
                                                                
                                                            case .cancel : break
                                                                
                                                            case .destructive : break
                                                            
                                                            }}))
                                                        self.present(alert,animated: true, completion: nil)
                                                    }
                                                    else if let b = Double(self.amount.text ?? ""),let c = Double(self.monthexp),b > c
                                                    {
                                                        
                                                        let alert = UIAlertController(title: "Error #A0038", message: "Not allow to exceed monthly limit" , preferredStyle : .alert)
                                                        alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                                                            switch action.style{
                                                             
                                                            case .default :
                                                                self.app_error_message_log(error_message: "unsuccessful payment Error #A0038 Not allow to exceed monthly limit")
                                                                
                                                                
                                                                break
                                                                
                                                            case .cancel : break
                                                                
                                                            case .destructive : break
                                                            
                                                            }}))
                                                        self.present(alert,animated: true, completion: nil)
                                                    }
                                
                                                        else
                                                    {
                                                                //    self.double_confirm.isHidden = false
                                                                 //                                         self.double_confirm_merchant.text = "Paid to Merchant \(self.merchant_name_single)"
                                                                                                       //
                                                                //                                          self.double_confirm_amount.text = self.amount.text
                                                        self.pin1.resignFirstResponder()
                                                        self.pin2.resignFirstResponder()
                                                        self.pin3.resignFirstResponder()
                                                        self.pin4.resignFirstResponder()
                                                        self.pin5.resignFirstResponder()
                                                        self.pin6.resignFirstResponder()
                                                        self.amount.resignFirstResponder()
                                                        
                                                        let alert = UIAlertController(title: "Paid to Merchant \(self.merchant_name_single)", message: "Amount : RM \(self.amount.text ?? "") " , preferredStyle : .alert)
                                                        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
                                                            alert.dismiss(animated:true, completion: nil)
                                                            self.comfirm_pay_task()
                                                         }))

                                                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                                                            alert.dismiss(animated:true, completion: nil)
                                                         }))
                                                        self.present(alert,animated: true, completion: nil)
                                                        
                                                    }
                                                    
                                                  
                                                                                               
                                                }
                                                else if result == "Invalid Pin Number"
                                                {
                                                    self.error_message.isHidden = false
                                                    self.error_message_label.isHidden = false
                                                    
                                                    self.error_message_label.text = "Invalid Pin Number"
                                                    
                                                    DispatchQueue.main.async()
                                                    {
                                                       
                                                    let alert = UIAlertController(title: "Error #A0031", message: "Invalid Pin Number" , preferredStyle : .alert)
                                                    alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                                                        switch action.style{
                                                         
                                                        case .default :
                                                             self.app_error_message_log(error_message: "unsuccessful payment Error #A0031 Invalid Pin Number")
                                                            
                                                            break
                                                            
                                                        case .cancel : break
                                                            
                                                        case .destructive : break
                                                        
                                                        }}))
                                                    self.present(alert,animated: true, completion: nil)
                                                    }
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
    func addDoneButtonOnKeyboard(){
           let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
           doneToolbar.barStyle = .default

           let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

           let items = [flexSpace, done]
           doneToolbar.items = items
           doneToolbar.sizeToFit()

           pin1.inputAccessoryView = doneToolbar
           pin2.inputAccessoryView = doneToolbar
           pin3.inputAccessoryView = doneToolbar
           pin4.inputAccessoryView = doneToolbar
           pin5.inputAccessoryView = doneToolbar
           pin6.inputAccessoryView = doneToolbar
           amount.inputAccessoryView = doneToolbar
       }
    @objc func doneButtonAction(){
          pin1.resignFirstResponder()
          pin2.resignFirstResponder()
          pin3.resignFirstResponder()
          pin4.resignFirstResponder()
          pin5.resignFirstResponder()
          pin6.resignFirstResponder()
          amount.resignFirstResponder()
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
    
      private func checkallinformation()
      {
          if !(pin1.text!.isEmpty) && !(pin2.text!.isEmpty) && !(pin3.text!.isEmpty) && !(pin4.text!.isEmpty) && !(pin5.text!.isEmpty) && !(pin6.text!.isEmpty)
        {
            confirm_btn.isEnabled = true
        }
        else
          {
            print("otp empty")
          }
    }
    
    
    @IBAction func pin1_input(_ sender: UITextField) {
        let x : Int? = sender.text?.count
        if  x! == 1
        {
          
          checkallinformation();
            pin2.becomeFirstResponder()
        }
        else
        {
             
            
        }
        checkMaxLength(textField: sender as! UITextField, maxLength: 1)
    }
    
    @IBAction func pin2_input(_ sender: UITextField) {
        
        let x : Int? = sender.text?.count
              if  x! == 1
              {
                
                checkallinformation();
                  pin3.becomeFirstResponder()
              }
              else
              {
                   
                  
              }
              checkMaxLength(textField: sender as! UITextField, maxLength: 1)
    }
    
    @IBAction func pin3_input(_ sender: UITextField) {
        let x : Int? = sender.text?.count
              if  x! == 1
              {
                
                checkallinformation();
                  pin4.becomeFirstResponder()
              }
              else
              {
                   
                  
              }
              checkMaxLength(textField: sender as! UITextField, maxLength: 1)
    }
    
    @IBAction func pin4_input(_ sender: UITextField) {
        let x : Int? = sender.text?.count
              if  x! == 1
              {
                
                checkallinformation();
                  pin5.becomeFirstResponder()
              }
              else
              {
                   
                  
              }
              checkMaxLength(textField: sender as! UITextField, maxLength: 1)
    }
    
    @IBAction func pin5_input(_ sender: UITextField) {
        let x : Int? = sender.text?.count
              if  x! == 1
              {
                
                checkallinformation();
                  pin6.becomeFirstResponder()
              }
              else
              {
                   
                  
              }
              checkMaxLength(textField: sender as! UITextField, maxLength: 1)
    }
    @IBAction func pin6_input(_ sender: UITextField) {
        let x : Int? = sender.text?.count
              if  x! == 1
              {
                
                checkallinformation();
                 
              }
              else
              {
                   
                  
              }
              checkMaxLength(textField: sender as! UITextField, maxLength: 1)
    }
    
    @IBAction func cover_password(_ sender: UIButton) {
        if(indicator == false) {
             pin1.isSecureTextEntry = false
             pin2.isSecureTextEntry = false
             pin3.isSecureTextEntry = false
             pin4.isSecureTextEntry = false
             pin5.isSecureTextEntry = false
             pin6.isSecureTextEntry = false
             
             change_password.setImage(UIImage(named: "eye_open"), for: .normal)
             indicator = true
               
          }
          else
          
          {
             pin1.isSecureTextEntry = true
             pin2.isSecureTextEntry = true
             pin3.isSecureTextEntry = true
             pin4.isSecureTextEntry = true
             pin5.isSecureTextEntry = true
             pin6.isSecureTextEntry = true
             indicator = false
             
             
             change_password.setImage(UIImage(named: "eye_close"), for: .normal)
             
             
                }
    }
    
    
    
    @IBAction func change_newotp(_ sender: UITextField) {
     let x : Int? = sender.text?.count
        if  sender.text!.count > 0
           {
                if result_otp == enter_newotp.text
                {
                    confirm_newotp.isHidden = false
                }
            else
                {
                     confirm_newotp.isHidden = true
                }
           }
        else
           {
             confirm_newotp.isHidden = true
            
           }
        
    }
    @IBAction func confirm_save_otp(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostPay_Save_OTP.aspx")
                                            guard let requestUrl = url2 else { fatalError() }
                                            // Prepare URL Request Object
                                            var request = URLRequest(url: requestUrl)
                                            request.httpMethod = "POST"
                                            
                                           
                                              let phoneinput = UserPreference.retreiveLoginID()
                                            let otpinput = enter_newotp.text
        if let myString = otpinput {
                                             let postString = "LoginID=\(phoneinput)&OTP=\(myString)";
                                                                                       // Set HTTP Request Body
                                                                                       request.httpBody = postString.data(using: String.Encoding.utf8);
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
                                                     let result = dataString
                                                DispatchQueue.main.async()
                                        {
                                            if result == "SAVE OTP BACKEND SYSTEM SUCCESS"
                                            {
                                                self.app_success_message_log(success_message: "Payment key save successful")
                                                print("SAVE OTP SUCCESSFULLY")
                                                let otpinput = self.enter_newotp.text
                                if let myString = otpinput {
                                                        UserDefaults.standard.set(myString,forKey: "OTP")
                                                }
                                                
                                                self.payment.isHidden = false
                                      
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
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func getnewotp(_ sender: UIButton) {
           if Reachability.isConnectedToNetwork(){
         let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostPay_Send_OTP.aspx")
                              guard let requestUrl = url2 else { fatalError() }
                              // Prepare URL Request Object
                              var request = URLRequest(url: requestUrl)
                              request.httpMethod = "POST"
                              
        mobile_id.text = UserPreference.retreiveLoginID().masked(4,reversed: true)
                                let phoneinput = UserPreference.retreiveLoginID()
                              // HTTP Request Parameters which will be sent in HTTP Request Body
                                let postString = "LoginID=\(phoneinput)";
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
                                       let result = dataString
                                        
                                        self.result_otp = result
                                       DispatchQueue.main.async() {
                                        self.checkotp1.isHidden = true
                                        self.checkotp2.isHidden = true
                                        self.getnewotp.isHidden = true
                                        self.setnewotp.isHidden = false
                                        self.startOtpTimer()
                                        
                                       // self.mobile_id.text?.masked(4)
                                        
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
    
    @IBAction func resend(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork(){
         let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostPay_Send_OTP.aspx")
                                     guard let requestUrl = url2 else { fatalError() }
                                     // Prepare URL Request Object
                                     var request = URLRequest(url: requestUrl)
                                     request.httpMethod = "POST"
                                     
                                    
                                       let phoneinput = UserPreference.retreiveLoginID()
                                     // HTTP Request Parameters which will be sent in HTTP Request Body
                                       let postString = "LoginID=\(phoneinput)";
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
                                              let result = dataString
                                                self.result_otp = result;    DispatchQueue.main.async() {
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
    private func startOtpTimer() {
            self.timer?.invalidate()
            self.totalTime = 30
                       self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
              }
    @objc func updateTimer()
    {
        resend_btn.isEnabled=false
        let myString = String(self.totalTime);
        self.resend_btn.setTitle(myString, for: .normal) // will show timer
       if totalTime != 0
       {
            totalTime -= 1  // decrease counter timer
        } else
       {
            if let timer = self.timer
            {
              timer.invalidate()
              self.timer = nil
                 self.resend_btn.setTitle("Resend", for: .normal)
                       resend_btn.isEnabled=true
                self.totalTime = 0
                
        }
      }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if( indicator == false && indicator2 == "YES")
        {
            let viewController = makeBarcodeScannerViewController()
                       viewController.title = "QRCode Scanner"
            viewController.headerViewController.titleLabel.text = "Scan QRCode"
            viewController.messageViewController.messages.scanningText = "Place the QRCode within the window to scan.The scan will start automatically"
            viewController.modalPresentationStyle = .fullScreen
                       present(viewController, animated: true, completion: nil)
        }
        else if (indicator == true)
        {
            self.dismiss(animated: true, completion: nil);
        }
        else if (indicator2 == "NO")
        {
            
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
     private func makeBarcodeScannerViewController() -> BarcodeScannerViewController {
       let viewController2 = BarcodeScannerViewController()
        viewController2.codeDelegate = self
        viewController2.errorDelegate = self
        viewController2.dismissalDelegate = self
        return viewController2
      
    }
}
extension ScanPayQRCode: BarcodeScannerCodeDelegate {
  func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
    print("Barcode Data: \(code)")
    print("Symbology Type: \(type)")
    
    if code == nil
    {
        
    }
    else
    {
        
       
        let result = code.components(separatedBy: "||")
        
        if result.count <= 0 || result.count > 3
        {
            print(result.count)
            error_message.isHidden = false
            error_message_label.isHidden = false
            let alert = UIAlertController(title: "Error ", message: "Invalid Merchant" , preferredStyle : .alert)
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
           // saveOTP()
            validateOTPTask()
            DailyExpTask()
            MonthlyExpTask()
            CreditBalanceTask()
            
            for i in 0..<result.count
        {
           
            if result.count == 3
            {
                self.type = "pay"
                merchantid = result[0]
                qr_amount = result[1]
                lqrcode = result[2]
                MerchantInfo_Task_Pay(type: self.type, merchantid: merchantid, qr_amount: qr_amount, lqrcode: lqrcode,qrcode:qrcode)
                
            }
            else if result.count == 2
            
            {
                self.type = "pay_cashier"
                merchantid = result[0]
                qrcode = result[1]
                MerchantInfo_Task_Pay(type: self.type, merchantid: merchantid, qr_amount: qr_amount, lqrcode: lqrcode,qrcode:qrcode)
            }
            
            else if result.count == 1
                       
            {
                self.type = "pay_cashier"
                merchantid = result[0]
                MerchantInfo_Task_Pay(type: self.type, merchantid: merchantid, qr_amount: qr_amount, lqrcode: lqrcode,qrcode:qrcode)
            }
        }
        }
      //getOTPTASK
         
        indicator2 = "NO"
        
        controller.dismiss(animated: true, completion: nil)
    }
    }
    func CheckDailyLimit()
    {
        if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostPay_CheckDailyExpLimit.aspx")
                                     guard let requestUrl = url2 else { fatalError() }
                                     // Prepare URL Request Object
                                     var request = URLRequest(url: requestUrl)
                                     request.httpMethod = "POST"
                                     
                                    
                                       let phoneinput = UserPreference.retreiveLoginID()
                                     // HTTP Request Parameters which will be sent in HTTP Request Body
                                       let postString = "LoginID=\(phoneinput)";
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
                                              let result = dataString
                                              DispatchQueue.main.async() {
                                               
                                                    if result == "Exceed Daily Limit"
                                                    {
                                                        self.error_message.isHidden = false
                                                        self.error_message_label.isHidden = false
                                                        self.error_message_label.text = "Exceed Daily Limit"
                                                        
                                                        DispatchQueue.main.async()
                                                        {
                                                             
                                                            let alert = UIAlertController(title: "Error #A0032", message: "Exceed Daily Limit" , preferredStyle : .alert)
                                                                alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                                                                    switch action.style{
                                                                                                               
                                                                        case .default :
                                                                        
                                                                        self.app_error_message_log(error_message: "unsuccessful payment Error #A0032 Exceed Daily Limit")
                                                                        
                                                                        break
                                                                                                                  
                                                                          case .cancel : break
                                                                                                                  
                                                                           case .destructive : break
                                                                                                              
                                                                          }}))
                                                                          self.present(alert,animated: true, completion: nil)
                                                        }
                                                    }
                                                else
                                                    {
                                                       
                                                        self.user_spend.text = result
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
    
    func MonthlyExpTask()
    {
          if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostPay_MonthlyExp.aspx")
                                            guard let requestUrl = url2 else { fatalError() }
                                            // Prepare URL Request Object
                                            var request = URLRequest(url: requestUrl)
                                            request.httpMethod = "POST"
                                            
                                           
                                              let phoneinput = UserPreference.retreiveLoginID()
                                            // HTTP Request Parameters which will be sent in HTTP Request Body
                                              let postString = "LoginID=\(phoneinput)";
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
                                                     let result = dataString
                                                     DispatchQueue.main.async() {
                                                      
                                                        self.monthexp = result
                                                                                              
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
    func DailyExpTask()
    {
         if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostPay_DailyExp.aspx")
                                     guard let requestUrl = url2 else { fatalError() }
                                     // Prepare URL Request Object
                                     var request = URLRequest(url: requestUrl)
                                     request.httpMethod = "POST"
                                     
                                    
                                       let phoneinput = UserPreference.retreiveLoginID()
                                     // HTTP Request Parameters which will be sent in HTTP Request Body
                                       let postString = "LoginID=\(phoneinput)";
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
                                              let result = dataString
                                              DispatchQueue.main.async() {
                                               
                                                self.dailyexp = result
                                                                                       
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
    
    func CreditBalanceTask()
    {
        if Reachability.isConnectedToNetwork(){
         let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostPay_CreditBalance.aspx")
                              guard let requestUrl = url2 else { fatalError() }
                              // Prepare URL Request Object
                              var request = URLRequest(url: requestUrl)
                              request.httpMethod = "POST"
                              
                             
                                let phoneinput = UserPreference.retreiveLoginID()
                              // HTTP Request Parameters which will be sent in HTTP Request Body
                                let postString = "LoginID=\(phoneinput)";
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
                                       let result = dataString
                                       DispatchQueue.main.async() {
                                        
                                        if result == "Don Have Balance"
                                        {
                                            self.error_message.isHidden = false
                                            self.error_message_label.isHidden = false
                                            self.error_message_label.text = "You Don Have Enough Balance To Pay"
                                            DispatchQueue.main.async()
                                              {
                                                 
                                                 let alert = UIAlertController(title: "Error #A0033", message: "Not Enough Balance" , preferredStyle : .alert)
                                                   alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                                                       switch action.style{
                                                                                                   
                                                         case .default :
                                                        self.app_error_message_log(error_message: "unsuccessful payment Error #A0033 Not Enough Balance")
                                                        
                                                        break
                                                                                                      
                                                         case .cancel : break
                                                                                                      
                                                           case .destructive : break
                                                                                                  
                                                           }}))
                                                      self.present(alert,animated: true, completion: nil)
                                            }
                                        }
                                        else
                                        {
                                            self.creditbalance = result
                                            self.CheckDailyLimit()
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
    func MerchantInfo_Task_Pay(type:String,merchantid:String,qr_amount:String,lqrcode:String,qrcode:String)
    {
        if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostPay_MerchantInfo.aspx")
                                                  guard let requestUrl = url2 else { fatalError() }
                                                  // Prepare URL Request Object
                                                  var request = URLRequest(url: requestUrl)
                                                  request.httpMethod = "POST"
                                                  
        let postString = "type=\(self.type)&merchantid=\(self.merchantid)&amount=\(self.amount.text ?? "")&dynamicqrcode=\(self.lqrcode)&qrcode=\(self.qrcode)";
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
                                    if dataString == "Invalid Merchant"
                                            {
                                                self.error_message.isHidden = false
                                                self.error_message_label.isHidden = false
                                                DispatchQueue.main.async()
                                                                                                  {
                                                                                                     
                                                                    
                                                                                                  let alert = UIAlertController(title: "Error #A0034", message: "Invalid Merchant" , preferredStyle : .alert)
                                                                                                  alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                                                                                                      switch action.style{
                                                                                                       
                                                                                                      case .default :
                                                                                                        
                                                                                                        self.app_error_message_log(error_message: "unsuccessful payment Error #A0034 Invalid Merchant")
                                                                        break
                                                                                                          
                                                                                                      case .cancel : break
                                                                                                          
                                                                                                      case .destructive : break
                                                                                                      
                                                                                                      }}))
                                                                                                  self.present(alert,animated: true, completion: nil)
                                                                                                  }
                                            }
                                            else
                                        {
                                            
                                    let result = dataString.components(separatedBy: ",")
                                                self.merchant_name.text = "Transaction with merchant "+result[0];
                                            self.merchant_name_single = result[0];
                                            
                                if result[1] == "cashier"
                                                {
                                                     self.amount.isEnabled = true
                                                }
                                                else if result[1] == "pay"
                                                {
                                                    self.amount.isEnabled = false
                                                    self.amount.text = self.qr_amount
                                                }
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
   
        
    
    func saveOTP()
    {
        let otp = UserDefaults.standard.set("",forKey: "OTP")
    }
    func retreivelocalOTP() -> String
    {
        let otp = UserDefaults.standard.string(forKey: "OTP") ?? ""
       return otp
    }
    
     public  func validateOTPTask()
       {
         if Reachability.isConnectedToNetwork(){
           let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostPay_Validate_OTP.aspx")
                       guard let requestUrl = url2 else { fatalError() }
                       // Prepare URL Request Object
                       var request = URLRequest(url: requestUrl)
                       request.httpMethod = "POST"
                        let currentotp = retreivelocalOTP()
                      
                         let phoneinput = UserPreference.retreiveLoginID()
                       // HTTP Request Parameters which will be sent in HTTP Request Body
                         let postString = "LoginID=\(phoneinput)";
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
                                let result = dataString
                                DispatchQueue.main.async() {
                                                                    if currentotp == ""
                                                                    {
                                                                        self.checkotp1.isHidden = false
                                                                        self.getnewotp.isHidden = false
                                                                    }
                                                                    else if result != currentotp
                                                                    {
                                                                        self.checkotp2.isHidden = false
                                                                        self.getnewotp.isHidden = false
                                                                        self.app_success_message_log(success_message: "Payment key different detected")
                                                                    }
                                                                    else if result == currentotp
                                                                    {
                                                                       self.payment.isHidden = false
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
    
    
}


// MARK: - BarcodeScannerErrorDelegate

extension ScanPayQRCode: BarcodeScannerErrorDelegate {
  func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
    print(error)
  }
}

// MARK: - BarcodeScannerDismissalDelegate

extension ScanPayQRCode: BarcodeScannerDismissalDelegate {
  func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
   indicator = true
    self.dismiss(animated: true, completion: nil)
  }
}
extension StringProtocol{
    
    func masked(_ n : Int = 4, reversed:Bool = false) -> String {
        let mask = String (repeating : "*", count: Swift.max(0,count - n))
        return reversed ? mask + suffix(n) : prefix(n) + mask
    }
}

extension Date{
    func currentTimeMillis() -> Int64{
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
