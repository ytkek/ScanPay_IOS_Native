//
//  SignUpStep1.swift
//  user
//
//  Created by Kek on 17/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

struct global{
    static var otp = ""
    static var loginid = ""
}
class SignUpStep1: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var verify: UIButton!
    @IBOutlet weak var otplabel: UILabel!
    @IBOutlet weak var otp1: UITextField!
    @IBOutlet weak var otp2: UITextField!
    @IBOutlet weak var otp3: UITextField!
    @IBOutlet weak var otp4: UITextField!
    @IBOutlet weak var otp5: UITextField!
    @IBOutlet weak var otp6: UITextField!
    var OTPresult = ""
    @IBOutlet weak var resend: UIButton!
    @IBOutlet weak var loginpasswordlabel: UILabel!
    @IBOutlet weak var loginpassword_input: UITextField!
    @IBOutlet weak var confirmpasswordlabel: UILabel!
    @IBOutlet weak var confirmpassword_input: UITextField!
    @IBOutlet weak var nextpage: UIButton!
    var timer: Timer?
    var totalTime = 30
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        DispatchQueue.main.async
        {
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
    override func viewDidLoad()
    {
        super.viewDidLoad()

        code.isEnabled = false
        verify.isHidden = true
        otplabel.isHidden = true
        otp1.isHidden = true
        otp2.isHidden = true
        otp3.isHidden = true
        otp4.isHidden = true
        otp5.isHidden = true
        otp6.isHidden = true
        resend.isHidden = true
        loginpasswordlabel.isHidden = true
        loginpassword_input.isHidden=true
        confirmpasswordlabel.isHidden = true
        confirmpassword_input.isHidden = true
        nextpage.isEnabled = false
        nextpage.alpha = 0.5
        phone.delegate = self
        otp1.delegate = self
        otp2.delegate = self
        otp3.delegate = self
        otp4.delegate = self
        otp5.delegate = self
        otp6.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
      
        
    }
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer)
    {
        phone.resignFirstResponder()
        otp1.resignFirstResponder()
        otp2.resignFirstResponder()
        otp3.resignFirstResponder()
        otp4.resignFirstResponder()
        otp5.resignFirstResponder()
        otp6.resignFirstResponder()
        loginpassword_input.resignFirstResponder()
        confirmpassword_input.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = "0123456789"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }
      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          self.view.endEditing(true)
        
       
          return false
      }
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
        
    }
    @IBAction func verify_click(_ sender: UIButton) {
              
        validatelogin()
    }
    
    func validatelogin()
    {
         if Reachability.isConnectedToNetwork()
        {
            let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostSignUp_Validate_LoginID.aspx")
            guard let requestUrl = url2 else { fatalError() }
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "POST"
            let value = "s7OyGTP6ZZmL7t3z"
            let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
            let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            let phoneinput = "60\(self.phone.text ?? "")"
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
                DispatchQueue.main.async()
                {
                if dataString == "This Login ID not available"
                {
                    let alert = UIAlertController(title: "Error #A0001", message: "This Login ID not available" , preferredStyle : .alert)
                    alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                    switch action.style
                    {
                        case .default : break
                        case .cancel : break
                        case .destructive : break
                                                                                        
                    }}))
                    self.present(alert,animated: true, completion: nil)
                }
                else if dataString == "This Login allow"
                {
                                 
                    self.sendOTP();
                    self.verify.isHidden = true
                    self.otplabel.isHidden = false
                    self.otp1.isHidden = false
                    self.otp2.isHidden = false
                    self.otp3.isHidden = false
                    self.otp4.isHidden = false
                    self.otp5.isHidden = false
                    self.otp6.isHidden = false
                    self.resend.isHidden = false
                    self.startOtpTimer()
                                                                                
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
            switch action.style
            {
                case .default : break
                case .cancel : break
                case .destructive : break
            }}))
            self.present(alert,animated: true, completion: nil)
        }
                             
           
    }
    
    func sendOTP()
    {
         if Reachability.isConnectedToNetwork()
         {
            let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostSignUp_Send_OTP.aspx")
            guard let requestUrl = url2 else { fatalError() }
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "POST"
            let value =  "s7OyGTP6ZZmL7t3z"
            let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
            let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            let phoneinput = "60\(self.phone.text ?? "")"
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
                DispatchQueue.main.async()
                {
                    self.OTPresult = dataString
                                
                }
            }
            }
            task.resume()
        }
        else
         {
            let alert = UIAlertController(title: "Error", message: "Internet Connection Failed" , preferredStyle : .alert)
                alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                switch action.style
                {
                case .default : break
                case .cancel : break
                case .destructive : break
                }}))
            self.present(alert,animated: true, completion: nil)
        }
    }
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
      
        if (textField.text!.characters.count > maxLength) {
            textField.deleteBackward()
        }
    }
    @IBAction func phoneinput(_ sender: UITextField) {
       
        let x : Int? = sender.text?.count
        
        if x! > 0 && x! <= 1 && sender.text == "0"
        {
            sender.text = ""
        }
        else
        {
            if  x! >= 8 && x! <= 10
            {
                verify.isHidden = false
            }
            else
            {
                verify.isHidden = true
                          
            }
                checkMaxLength(textField: sender as! UITextField, maxLength: 10)
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
                        
                        checkallinformation(); otp6.becomeFirstResponder()
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
          
          checkallinformation();
        }
        else
        {
             
            
        }
        checkMaxLength(textField: sender as! UITextField, maxLength: 1)
    }
    
    
    @IBAction func resend_click(_ sender: UIButton) {
       
        self.sendOTP()
            startOtpTimer()
        
    }
   
    
    private func checkallinformation()
    {
        if !(otp1.text!.isEmpty) && !(otp2.text!.isEmpty) && !(otp3.text!.isEmpty) && !(otp4.text!.isEmpty) && !(otp5.text!.isEmpty) && !(otp6.text!.isEmpty)
        {
            if self.OTPresult == "\(otp1.text ?? "")\(otp2.text ?? "")\(otp3.text ?? "")\(otp4.text ?? "")\(otp5.text ?? "")\(otp6.text ?? "")"
            {
                otplabel.isHidden = true
                otp1.isHidden = true
                otp2.isHidden = true
                otp3.isHidden = true
                otp4.isHidden = true
                otp5.isHidden = true
                otp6.isHidden = true
                resend.isHidden = true
                verify.isHidden = true
                phone.isEnabled = false
                loginpasswordlabel.isHidden = false
                loginpassword_input.isHidden=false
                confirmpasswordlabel.isHidden = false
                confirmpassword_input.isHidden = false
            }
            else
            {
                let alert = UIAlertController(title: "Error #A0003", message: "Incorrect OTP" , preferredStyle : .alert)
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
            print("otp empty")
            
        }
    }
        private func startOtpTimer()
    {
        self.timer?.invalidate()
        self.totalTime = 30
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer()
    {
        resend.isEnabled=false
        let myString = String(self.totalTime);
        self.resend.setTitle(myString, for: .normal) // will show timer
       if totalTime != 0
       {
            totalTime -= 1  // decrease counter timer
        }
       else
       {
            if let timer = self.timer
            {
              timer.invalidate()
              self.timer = nil
              self.resend.setTitle("Resend", for: .normal)
              resend.isEnabled=true
              self.totalTime = 0
                
            }
      }
    }

  
   
    @IBAction func loginpassword_input(_ sender: UITextField) {
        
        checkpassword()
    }
    
    @IBAction func confirmpassword_input(_ sender: UITextField) {
        checkpassword()
    }
    
    
    @IBAction func loginpass_done(_ sender: UITextField) {
        sender.resignFirstResponder()
      
        
    }
    
    @IBAction func confirmpass_done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
   
       func signup_update_password()
       {
        if Reachability.isConnectedToNetwork()
        {
         let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostSignUp_Update_App_Password.aspx")
        guard let requestUrl = url2 else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let value =  "s7OyGTP6ZZmL7t3z"
        let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
        let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        let phoneinput = "60\(self.phone.text ?? "")"
        global.otp = self.OTPresult
        global.loginid = phoneinput
        let postString = "LoginID=\(phoneinput)&AppPassword=\(confirmpassword_input.text ?? "")&Otp=\(self.OTPresult ?? "")&Token=\(postStringencoding ?? "")";
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
            DispatchQueue.main.async()
            {
                if dataString == "Update Password Success"
                {
                    let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "signupstep2") as! UIViewController
                    nextViewController.modalPresentationStyle = .fullScreen
                    self.present(nextViewController,animated:true,completion:nil)
                }
                else
                {
                    let alert = UIAlertController(title: "Error #A0004", message: "Update Password Fail" , preferredStyle : .alert)
                    alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                    switch action.style
                    {
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
                switch action.style
                {
                    case .default : break
                    case .cancel : break
                    case .destructive : break
                 }}))
                    self.present(alert,animated: true, completion: nil)
        }
    }
    @IBAction func nextpage_click(_ sender: UIButton) {
       
        if loginpassword_input.text?.count ?? 0 >= 4 && loginpassword_input.text?.isAlphanumeric ?? false
        {
           if loginpassword_input.text == confirmpassword_input.text
           {
               self.signup_update_password()
           }
           else
           {
              let alert = UIAlertController(title: "Error #A0002", message: "Password Not Match" , preferredStyle : .alert)
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
            let alert = UIAlertController(title: "", message: "At least 4 char and Alphanumeric" , preferredStyle : .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                switch action.style{
                 
                case .default : break
                    
                case .cancel : break
                    
                case .destructive : break
                
                }}))
            self.present(alert,animated: true, completion: nil)
        }
    
    }
    
    private func checkpassword_condition()
    {
        if loginpassword_input.text?.count ?? 0 >= 4 && ((loginpassword_input.text?.isAlphanumeric) != false)
        {
           if loginpassword_input.text == confirmpassword_input.text
           {
               nextpage.isEnabled = true
               nextpage.alpha = 1.0
           }
           else
           {
               nextpage.isEnabled = false
               nextpage.alpha = 0.5
           }
        }
        else
        {
            
        }
    }
    
    private func checkpassword()
    {
        if(loginpassword_input.text != "" ||  confirmpassword_input.text != "")
        {
            if loginpassword_input.text == confirmpassword_input.text
            {
                nextpage.isEnabled = true
                nextpage.alpha = 1.0
            }
            else
            {
                
                
                nextpage.isEnabled = true
                nextpage.alpha = 1.0
            }
        }
        else
        {
            nextpage.isEnabled = false
            nextpage.alpha = 0.5
        }
        
    }
 
  
    @objc func keyboardWillShow(notification: NSNotification) {
         print("keyboard")
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
            if self.view.frame.origin.y != 0
            {
                self.view.frame.origin.y = 30
            }
                               
        }
        else
        {
            if self.view.frame.origin.y != 0
            {
                self.view.frame.origin.y = 0
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

}

extension String {
    var isAlphanumeric: Bool {
        let regexInclude = try! NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*[0-9])(?!.*[^A-Za-z0-9]).{4,}$")
               return regexInclude.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count)) != nil
       // return  range(of: "/^(?=.*[0-9)(?=.*[a-zA-Z])([a-zA-Z0-9]+)$/",options: .regularExpression) == nil
    }
}
