//
//  SignUpStep2.swift
//  user
//
//  Created by Kek on 17/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class SignUpStep2: UIViewController {

    @IBOutlet weak var name_input: UITextField!
    @IBOutlet weak var email_input: UITextField!
    @IBOutlet weak var nextpage: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       
         nextpage.isEnabled=false
        nextpage.alpha = 0.5
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
               self.view.addGestureRecognizer(tapGesture)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer)
       {
        name_input.resignFirstResponder()
        email_input.resignFirstResponder()
       }
    @IBAction func name(_ sender: UITextField) {
        checkinformation()
    }
    
    @IBAction func email(_ sender: UITextField) {
        if (sender.text?.isValidEmail())!
        {
            checkinformation()
            print("Valid email")
        }
        else
        {
            checkinformation()
            print("InValid email")
        }
    }
    
    @IBAction func name_return(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    @IBAction func email_return(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func Update_User_Info()
    {
        if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostSignUp_Update_User_Info.aspx")
                                  guard let requestUrl = url2 else { fatalError() }
                                  // Prepare URL Request Object
                                  var request = URLRequest(url: requestUrl)
                                  request.httpMethod = "POST"
            
                let value =  "s7OyGTP6ZZmL7t3z"
                              
                              
               let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
               
               let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            
        let phoneinput = global.loginid
                                  // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "Name=\(name_input.text ?? "")&Email=\(email_input.text ?? "")&LoginID=\(phoneinput ?? "")&Otp=\(global.otp ?? "")&Token=\(postStringencoding ?? "")";
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
                                                                                    if dataString == "Update UserInfo Success"
                                                                                    {
                                                                                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "signupstep3") as! UIViewController
                                                                    nextViewController.modalPresentationStyle = .fullScreen
                                                                                        self.present(nextViewController,animated:true,completion:nil)
                                                                                        }
                                                                                        else
                                                                                    {
                                                                                        let alert = UIAlertController(title: "Error #A0013", message: "Update UserInfo Fail" , preferredStyle : .alert)
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
    @IBAction func intent_signupstep3(_ sender: UIButton) {
        
        if !(name_input.text!.isEmpty) && !(email_input.text!.isEmpty)
        {
            if email_input.text?.isValidEmail() ?? false
            {
                Update_User_Info()
            }
            else
            {
                let alert = UIAlertController(title: "Error #A0012", message: "Invalid Email" , preferredStyle : .alert)
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
            let alert = UIAlertController(title: "Error #A0011", message: "Name or Email is Empty" , preferredStyle : .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                switch action.style{
                 
                case .default : break
                    
                case .cancel : break
                    
                case .destructive : break
                
                }}))
            self.present(alert,animated: true, completion: nil)
            
        }
        
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
    private func checkinformation()
    {
     //  if !(name_input.text!.isEmpty) && !(email_input.text!.isEmpty)
      // {
        nextpage.isEnabled=true
        nextpage.alpha = 1.0
      //  }
    }
}
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
