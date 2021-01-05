//
//  ForgotPassword.swift
//  user
//
//  Created by Kek on 14/05/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class ForgotPassword: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var loginid: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var sendmypassword: UIButton!
    
    
      override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            DispatchQueue.main.async {
               if UIDevice.current.hasTopNotch
               {
                    
                let screensize: CGRect = UIScreen.main.bounds
                let myView = UIView(frame: CGRect(x: 0, y: -30, width: screensize.width, height: 30))
                myView.backgroundColor = .white
                
                self.view.addSubview(myView)
                
               if #available(iOS 13.0, *)
                              {
                                  let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
                                  statusBar.backgroundColor = .white
                                  UIApplication.shared.keyWindow?.addSubview(statusBar)
                              }
                              else
                              {
                                  self.navigationController?.setStatusBar(backgroundColor:.white)
                              }
                self.view.frame.origin.y = 30
                                                 
                }
                else
               {
                 self.navigationController?.setStatusBar(backgroundColor:.white)
                    self.view.frame.origin.y = 0
                                                    
                                                    
               }
            }
           
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        loginid.delegate = self
        email.delegate = self
        sendmypassword.isHidden = true
        
       
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.addDoneButtonOnKeyboard()
       
        
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
    private func sendpassword()
       {
        if Reachability.isConnectedToNetwork(){
           let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/Recover_loginid_password.aspx")
                                     guard let requestUrl = url2 else { fatalError() }
                                     // Prepare URL Request Object
                                     var request = URLRequest(url: requestUrl)
                                     request.httpMethod = "POST"
                    let value =  "s7OyGTP6ZZmL7t3z"
                                                    
                    let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
                                                    
                    let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
           
                                     // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "LoginID=60\(loginid.text ?? "")&Email=\(email.text ?? "")&Token=\(postStringencoding ?? "")";
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
                                                                                        let alert = UIAlertController(title: "Alert", message: dataString , preferredStyle : .alert)
                                                                                                                                          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                                                                                                                                            self.sendmypassword.isEnabled = true
                                                                                                                                          }))
                                                                                                       self.present(alert,animated: true, completion: nil)
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
    @IBAction func Email_changed(_ sender: UITextField) {
    }
    @IBAction func LoginID_changed(_ sender: UITextField) {
        
        let x : Int? = sender.text?.count
               if  x! >= 8 && x! <= 10
               {
                  sendmypassword.isHidden = false
                   
               }
               else
               {
                    sendmypassword.isHidden = true
                   
               }
               checkMaxLength(textField: sender as! UITextField, maxLength: 10)
    }
    @IBAction func sendmypassword_btn(_ sender: UIButton) {
        if loginid.text != ""
        {
            if email.text?.isValidEmail() ?? false
            {
                sendmypassword.isEnabled = false
                self.sendpassword()
            }
            else
            {
                let alert = UIAlertController(title: "", message: "Invalid Email" , preferredStyle : .alert)
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
    
  
    @objc func keyboardWillShow(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
               
               if UIDevice.current.hasTopNotch
                                      {
                                           
                                        if self.view.frame.origin.y == 30
                                                           {
                                                           self.view.frame.origin.y -= 130
                                                           }
                                    }
                                    else
                                      {
                                       if self.view.frame.origin.y == 0
                                                          {
                                                                  self.view.frame.origin.y -= 100
                                                          }
                                    }
               }
           }
       

       @objc func keyboardWillHide(notification: NSNotification) {
           if UIDevice.current.hasTopNotch
                          {
                              if self.view.frame.origin.y != 0 {
                                                    self.view.frame.origin.y = 30
                                                }
                        
                          }
                          else
                          {
                              if self.view.frame.origin.y != 0 {
                                        self.view.frame.origin.y = 0
                                    }
                              
                          }
       }

}

