//
//  SignUpStep3.swift
//  user
//
//  Created by Kek on 17/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class SignUpStep3: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var otp1: UITextField!
    @IBOutlet weak var otp2: UITextField!
    @IBOutlet weak var otp3: UITextField!
    @IBOutlet weak var otp4: UITextField!
    @IBOutlet weak var otp5: UITextField!
    @IBOutlet weak var otp6: UITextField!
    
    @IBOutlet weak var show_password: UIButton!
    @IBOutlet weak var checkbox: UIButton!
    var indicator = false;
    var checkbox_indicator = false;
    
    @IBOutlet weak var finish_btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

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
        // Do any additional setup after loading the view.
        self.addDoneButtonOnKeyboard()
        finish_btn.isEnabled = false
        finish_btn.alpha = 0.5
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
              self.view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer)
       {
           
           otp1.resignFirstResponder()
           otp2.resignFirstResponder()
           otp3.resignFirstResponder()
           otp4.resignFirstResponder()
           otp5.resignFirstResponder()
           otp6.resignFirstResponder()
        
           
       }
    @IBAction func intentviewagreement(_ sender: UIButton) {
        
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "viewagreement") as! UIViewController
            nextViewController.modalPresentationStyle = .fullScreen
              present(nextViewController,animated:true,completion:nil)
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
        
    }

    @objc func doneButtonAction(){
        otp1.resignFirstResponder()
        otp2.resignFirstResponder()
        otp3.resignFirstResponder()
        otp4.resignFirstResponder()
        otp5.resignFirstResponder()
        otp6.resignFirstResponder()
    }
    
    @IBAction func check_box_click(_ sender: UIButton) {
        
        if(checkbox_indicator == false)
        {
            checkbox.setImage(UIImage(named: "tickbox_checked"), for: .normal)
            checkbox_indicator = true
            
        }
        else
        {
            checkbox.setImage(UIImage(named: "tickbox_unchecked"), for: .normal)
                       checkbox_indicator = false
        }
        checkallinformation()
    }
    
    
    
    
    @IBAction func show_password_click(_ sender: UIButton) {
         if(indicator == false) {
            otp1.isSecureTextEntry = false
            otp2.isSecureTextEntry = false
            otp3.isSecureTextEntry = false
            otp4.isSecureTextEntry = false
            otp5.isSecureTextEntry = false
            otp6.isSecureTextEntry = false
            
            show_password.setImage(UIImage(named: "eye_open"), for: .normal)
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
            
            
            show_password.setImage(UIImage(named: "eye_close"), for: .normal)
            
            
               }

              
    }
    
    @IBAction func otp1_input(_ sender: UITextField) {
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
    
    @IBAction func otp2_input(_ sender: UITextField) {
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
    
    @IBAction func otp3_input(_ sender: UITextField) {
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
  
    @IBAction func otp4_input(_ sender: UITextField) {
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
    
    @IBAction func otp5_input(_ sender: UITextField) {
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
 
    @IBAction func otp6_input(_ sender: UITextField) {
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
    
    
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func Update_MemberList()
    {
          if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostSignUp_Update_MemberList.aspx")
                                    guard let requestUrl = url2 else { fatalError() }
                                    // Prepare URL Request Object
                                    var request = URLRequest(url: requestUrl)
                                    request.httpMethod = "POST"
        
          let phoneinput = global.loginid
                                    // HTTP Request Parameters which will be sent in HTTP Request Body
          let postString = "LoginID=\(phoneinput ?? "")&Otp=\(global.otp ?? "")";
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
                                                                                      if dataString == "User Register Success"
                                                                                      {
                                                                                          let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "viewcontroller") as! UIViewController
                                                                    nextViewController.modalPresentationStyle = .fullScreen
                                                                                          self.present(nextViewController,animated:true,completion:nil)
                                                                                          }
                                                                                            else
                                                                                      {
                                                                                        let alert = UIAlertController(title: "Error #A0023", message: "User Register Fail" , preferredStyle : .alert)
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
            let alert = UIAlertController(title: "Error", message: "Internet Connection Failed" , preferredStyle : .alert)
                       alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                           switch action.style{
                                                                                                                                                                
                           case .default : break
                                                                                                                                                                   
                          case .cancel : break
                                                                                                                                                                   
                         case .destructive : break
                                                                                                                                                               
                       }}))
                       self.present(alert,animated: true, completion: nil)
        }
    }
    func Update_Confirm()
    {
          if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostSignUp_Update_Confirm.aspx")
                                  guard let requestUrl = url2 else { fatalError() }
                                  // Prepare URL Request Object
                                  var request = URLRequest(url: requestUrl)
                                  request.httpMethod = "POST"
      
        let phoneinput = global.loginid
                                  // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "LoginID=\(phoneinput ?? "")&Otp=\(global.otp ?? "")";
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
                                                                                    if dataString == "Update Confirm Success"
                                                                                    {
                                                                                        self.Update_MemberList()
                                                                                        }
                                                                        else
                                                                                    {
                                                    let alert = UIAlertController(title: "Error #A0024", message: "Update Confirm Fail" , preferredStyle : .alert)
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
            let alert = UIAlertController(title: "Error", message: "Internet Connection Failed" , preferredStyle : .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                switch action.style{
                                                                                                                                                     
                case .default : break
                                                                                                                                                        
               case .cancel : break
                                                                                                                                                        
              case .destructive : break
                                                                                                                                                    
            }}))
            self.present(alert,animated: true, completion: nil)
        }
    }
    func Update_User_Payment()
    {
        if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostSignUp_Update_Payment_Info.aspx")
                                  guard let requestUrl = url2 else { fatalError() }
                                  // Prepare URL Request Object
                                  var request = URLRequest(url: requestUrl)
                                  request.httpMethod = "POST"
        let paymentpin = "\(otp1.text ?? "")\(otp2.text ?? "")\(otp3.text ?? "")\(otp4.text ?? "")\(otp5.text ?? "")\(otp6.text ?? "")"
        let phoneinput = global.loginid
                                  // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "PaymentPin=\(paymentpin ?? "")&LoginID=\(phoneinput ?? "")&Otp=\(global.otp ?? "")";
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
                                                                                    if dataString == "Update PaymentPin Success"
                                                                                    {
                                                                                        self.Update_Confirm()
                                                                                        }
                                                                                        else
                                                                                    {
                                                                                        let alert = UIAlertController(title: "Error #A0025", message: "Update Payment Fail" , preferredStyle : .alert)
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
            let alert = UIAlertController(title: "Error", message: "Internet Connection Failed" , preferredStyle : .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                switch action.style{
                                                                                                                                                     
                case .default : break
                                                                                                                                                        
               case .cancel : break
                                                                                                                                                        
              case .destructive : break
                                                                                                                                                    
            }}))
            self.present(alert,animated: true, completion: nil)
        }
    }
    
    @IBAction func finish(_ sender: UIButton) {
        
        
         if !(otp1.text!.isEmpty) && !(otp2.text!.isEmpty) && !(otp3.text!.isEmpty) && !(otp4.text!.isEmpty) && !(otp5.text!.isEmpty) && !(otp6.text!.isEmpty)
                    {
                        if checkbox_indicator == true
                        {
                            Update_User_Payment()
                            
                        }
                       else
                        {
                            let alert = UIAlertController(title: "Error #A0021", message: "Unchecked Agreement" , preferredStyle : .alert)
                                           alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                                               switch action.style{
                                                
                                               case .default : break
                                                   
                                               case .cancel : break
                                                   
                                               case .destructive : break
                                               
                                               }}))
                                           self.present(alert,animated: true, completion: nil)
                           //finish_btn.isEnabled = false
                       }
                        
                    }
                    else
                    {
                       let alert = UIAlertController(title: "Error #A0022", message: "Unfill 6 Digit PIN" , preferredStyle : .alert)
                       alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                           switch action.style{
                            
                           case .default : break
                               
                           case .cancel : break
                               
                           case .destructive : break
                           
                           }}))
                       self.present(alert,animated: true, completion: nil)
                        print("otp empty")
                        
                    }
        
       
        
    }
    private func checkallinformation()
         {
             if !(otp1.text!.isEmpty) && !(otp2.text!.isEmpty) && !(otp3.text!.isEmpty) && !(otp4.text!.isEmpty) && !(otp5.text!.isEmpty) && !(otp6.text!.isEmpty)
             {
                 if checkbox_indicator == true
                 {
                    finish_btn.isEnabled = true
                    finish_btn.alpha = 1.0
                 }
                else
                 {
                    finish_btn.isEnabled = true
                    finish_btn.alpha = 1.0
                }
                 
             }
             else
             {
                finish_btn.isEnabled = true
                finish_btn.alpha = 1.0
                 
                 
             }
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
      }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */  func checkMaxLength(textField: UITextField!, maxLength: Int) {
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
