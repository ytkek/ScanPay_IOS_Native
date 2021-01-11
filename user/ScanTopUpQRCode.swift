//
//  ScanTopUpQRCode.swift
//  user
//
//  Created by Kek on 25/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit
import BarcodeScanner

class ScanTopUpQRCode: UIViewController ,UITextFieldDelegate{
    var indicator = false;
    var indicator2 = "YES";
    @IBOutlet weak var checkotp1: UIView!
    @IBOutlet weak var checkotp2: UIView!
    @IBOutlet weak var getnewotp: UIButton!
    @IBOutlet weak var resend_btn: UIButton!
    @IBOutlet weak var setnewotp: UIView!
    @IBOutlet weak var mobile_id: UILabel!
    @IBOutlet weak var change_otp: UITextField!
    @IBOutlet weak var confirm_saveotp: UIButton!
    @IBOutlet weak var topup: UIView!
    @IBOutlet weak var topup_creditbalance: UITextField!
    @IBOutlet weak var topup_merchantname: UILabel!
    var merchant_name_single = ""
    @IBOutlet weak var topup_amount: UITextField!
    @IBOutlet weak var error_message: UIView!
    @IBOutlet weak var error_message_label: UILabel!
    @IBOutlet weak var topup_success: UIView!
    @IBOutlet weak var topup_success_amount: UILabel!
    @IBOutlet weak var topup_success_merchant: UILabel!
    @IBOutlet weak var topup_success_date: UILabel!
    var timer: Timer?
    var totalTime = 30
    var result_otp = ""
    var type = ""
    var merchantid = ""
    var qr_amount = ""
    var lqrcode = ""
    var qrcode = ""
    
    override func viewWillAppear(_ animated: Bool) {
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.hasTopNotch
        {
            self.topup.frame.origin.y += 50
            self.checkotp1.frame.origin.y += 50
            self.checkotp2.frame.origin.y += 50
            self.setnewotp.frame.origin.y += 50
            self.error_message.frame.origin.y += 50
            self.topup_success.frame.origin.y += 50
            self.getnewotp.frame.origin.y += 50
        }
        else
        {
                   
        }
        checkotp1.isHidden = true
        checkotp2.isHidden = true
        getnewotp.isHidden = true
        setnewotp.isHidden = true
        confirm_saveotp.isHidden = true
        change_otp.delegate = self
        topup.isHidden = true
        error_message.isHidden = true
        error_message_label.isHidden = true
        topup_success.isHidden = true
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                self.view.endEditing(true)
                return false
            }
    @IBAction func topup_successfully_close(_ sender: UIButton) {
         self.dismiss(animated: true, completion: nil)
    }
    
    func comfirm_topup_task()
    {
        if Reachability.isConnectedToNetwork()
        {
            let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostPay_Confirm_Pay.aspx")
            guard let requestUrl = url2 else { fatalError() }
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "POST"
            let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
            let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
            let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            let postString = "LoginID=\(UserPreference.retreiveLoginID())&MerchantID=\(self.merchantid)&MerchantName=\(self.merchant_name_single)&type=\(self.type)&Amount=\(self.qr_amount)&qrcode=\(self.qrcode)&dyqrcode=\(self.lqrcode)&Token=\(postStringencoding ?? "")";
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
                    if dataString == "payment success"
                    {
                      self.app_success_message_log(success_message: "success topup \(self.qrcode)\(self.lqrcode)")
                      self.topup_success.isHidden = false
                      self.topup_success_amount.text = "Amount: "+self.qr_amount
                      var currentDateTime = Date()
                      let dateFormatter = DateFormatter()
                      dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
                      let result = dateFormatter.string(from:currentDateTime)
                      self.topup_success_date.text = result
                      self.topup_success_merchant.text = self.merchant_name_single
                    }
                    else
                    {
                      self.app_error_message_log(error_message:"unsuccess topup \(self.qrcode)\(self.lqrcode)" )
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
            switch action.style
            {
              case .default : break
              case .cancel : break
              case .destructive : break
            }}))
              self.present(alert,animated: true, completion: nil)
        }
    }
    
    func app_error_message_log(error_message : String?)
    {
        if Reachability.isConnectedToNetwork()
        {
            let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostApp_Error_Message.aspx")
            guard let requestUrl = url2 else { fatalError() }
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "POST"
            let postString = "LoginID=\(UserPreference.retreiveLoginID())&Message=\(error_message ?? "")";
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
                                                                 
                                                            
            }
            }
            task.resume()
            }
            else
            {
              let alert = UIAlertController(title: "Error #A0090", message: "Internet Connection Failed" , preferredStyle : .alert)
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
    func app_success_message_log(success_message : String?)
       {
           if Reachability.isConnectedToNetwork()
           {
                let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostApp_Success_Message.aspx")
                guard let requestUrl = url2 else { fatalError() }
                var request = URLRequest(url: requestUrl)
                request.httpMethod = "POST"
                let postString = "LoginID=\(UserPreference.retreiveLoginID())&Message=\(success_message ?? "")";
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
                                                                    
                }
                }
                    task.resume()
                }
                else
                {
                    let alert = UIAlertController(title: "Error #A0090", message: "Internet Connection Failed" , preferredStyle : .alert)
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
    
    
    @IBAction func getnewotp(_ sender: UIButton)
    {
        if Reachability.isConnectedToNetwork()
        {
        let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostPay_Send_OTP.aspx")
        guard let requestUrl = url2 else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
        let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
        let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        mobile_id.text = UserPreference.retreiveLoginID().masked(4,reversed: true)
        let phoneinput = UserPreference.retreiveLoginID()
        let postString = "LoginID=\(phoneinput)&Token=\(postStringencoding ?? "")";
        request.httpBody = postString.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error
        {
            return
        }
        if let data = data, let dataString = String(data: data, encoding: .utf8)
        {
            let result = dataString
            self.result_otp = result
            DispatchQueue.main.async()
            {
                self.checkotp1.isHidden = true
                self.checkotp2.isHidden = true
                self.getnewotp.isHidden = true
                self.setnewotp.isHidden = false
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
            switch action.style
            {
              case .default : break
              case .cancel : break
              case .destructive : break
            }}))
            self.present(alert,animated: true, completion: nil)
        }
    }
    
    @IBAction func change_newotp(_ sender: UITextField) {
        let x : Int? = sender.text?.count
               if  sender.text!.count > 0
                  {
                       if result_otp == change_otp.text
                       {
                           confirm_saveotp.isHidden = false
                       }
                   else
                       {
                            confirm_saveotp.isHidden = true
                       }
                  }
               else
                  {
                    confirm_saveotp.isHidden = true
                   
                  }
               
    }
    
    
    @IBAction func confirm_saveotp(_ sender: UIButton)
    {
        if Reachability.isConnectedToNetwork()
        {
            let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostPay_Save_OTP.aspx")
            guard let requestUrl = url2 else { fatalError() }
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "POST"
            let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
            let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
            let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            let phoneinput = UserPreference.retreiveLoginID()
            let otpinput = change_otp.text
        if let myString = otpinput
        {
           let postString = "LoginID=\(phoneinput)&OTP=\(myString)&Token=\(postStringencoding ?? "")";
            request.httpBody = postString.data(using: String.Encoding.utf8);
        }
          let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
          if let error = error
          {
             print("Error took place \(error)")
             return
          }
         if let data = data, let dataString = String(data: data, encoding: .utf8)
         {
            print("Response data string:\n \(dataString)")
            let result = dataString
             DispatchQueue.main.async()
             {
               if result == "SAVE OTP BACKEND SYSTEM SUCCESS"
               {
                 self.app_success_message_log(success_message: "Topup key save successful")
                 print("SAVE OTP SUCCESSFULLY")
                 let otpinput = self.change_otp.text
                 if let myString = otpinput
                 {
                   UserDefaults.standard.set(myString,forKey: "OTP")
                 }
                   self.topup.isHidden = false
                                      
                }
                else
                {
                    self.app_error_message_log(error_message: "Topup key save unsucessful")
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
                       switch action.style
                       {
                       case .default : break
                       case .cancel : break
                       case .destructive : break
                      }}))
                       self.present(alert,animated: true, completion: nil)
        }
        
    }
    
    @IBAction func confirm_topup(_ sender: UIButton)
    {
        let alert = UIAlertController(title: "Topup from Merchant \(self.merchant_name_single)", message: "Amount : RM \(self.topup_amount.text ?? "") " , preferredStyle : .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
        alert.dismiss(animated:true, completion: nil)
        self.comfirm_topup_task()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        alert.dismiss(animated:true, completion: nil)
        }))
        self.present(alert,animated: true, completion: nil)
                                                               
    }
    

    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func resend(_ sender: UIButton)
    {
        if Reachability.isConnectedToNetwork()
        {
            let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostPay_Send_OTP.aspx")
            guard let requestUrl = url2 else { fatalError() }
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "POST"
            let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
            let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
            let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            let phoneinput = UserPreference.retreiveLoginID()
            let postString = "LoginID=\(phoneinput)&Token=\(postStringencoding ?? "")";
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
              let result = dataString
              self.result_otp = result;
              DispatchQueue.main.async()
              {
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
            switch action.style
            {
              case .default : break
              case .cancel : break
              case .destructive : break
            }}))
            self.present(alert,animated: true, completion: nil)
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
          resend_btn.isEnabled=false
          let myString = String(self.totalTime);
          self.resend_btn.setTitle(myString, for: .normal) // will show timer
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
       private func makeBarcodeScannerViewController() -> BarcodeScannerViewController {
              let viewController = BarcodeScannerViewController()
              viewController.codeDelegate = self
              viewController.errorDelegate = self
              viewController.dismissalDelegate = self
              return viewController
            
          }


}
extension ScanTopUpQRCode: BarcodeScannerCodeDelegate {
  func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
    print("Barcode Data: \(code)")
    print("Symbology Type: \(type)")

    if code == nil
       {
           
       }
       else
       {
           let result = code.components(separatedBy: "||")
           
           if result.count <= 2 || result.count > 3
           {
              
               error_message.isHidden = false
               error_message_label.isHidden = false
           }
        
        else
        {
            validateOTPTask()
            CreditBalanceTask()
                   
            if result.count == 3
            {
                self.type = "topup"
                merchantid = result[0]
                qr_amount = result[1]
                lqrcode = result[2]
                MerchantInfo_Task_Topup(type: self.type, merchantid: merchantid, qr_amount: qr_amount, lqrcode: lqrcode,qrcode:qrcode)
                       
            }
        }
        
    }
    
    indicator2 = "NO"
     controller.dismiss(animated: true, completion: nil)
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
            if Reachability.isConnectedToNetwork()
            {
              let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostPay_Validate_OTP.aspx")
              guard let requestUrl = url2 else { fatalError() }
              var request = URLRequest(url: requestUrl)
              request.httpMethod = "POST"
              let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
              let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
              let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
              let currentotp = retreivelocalOTP()
              let phoneinput = UserPreference.retreiveLoginID()
              let postString = "LoginID=\(phoneinput)&Token=\(postStringencoding ?? "")";
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
               let result = dataString
               DispatchQueue.main.async()
               {
                if currentotp == ""
                {
                   self.checkotp1.isHidden = false
                   self.getnewotp.isHidden = false
                   self.topup.isHidden = true
                }
                else if result != currentotp
                {
                  self.checkotp2.isHidden = false
                  self.getnewotp.isHidden = false
                  self.topup.isHidden = true
                }
                else if result == currentotp
                {
                  self.topup.isHidden = false
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
                switch action.style
                {
                   case .default : break
                   case .cancel : break
                   case .destructive : break
                 }}))
                self.present(alert,animated: true, completion: nil)
            }
                            
          }
    
    func CreditBalanceTask()
    {
        if Reachability.isConnectedToNetwork()
        {
         let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostPay_CreditBalance.aspx")
         guard let requestUrl = url2 else { fatalError() }
         var request = URLRequest(url: requestUrl)
         request.httpMethod = "POST"
         let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
         let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
         let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
         let phoneinput = UserPreference.retreiveLoginID()
         let postString = "LoginID=\(phoneinput)&Token=\(postStringencoding ?? "")";
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
            let result = dataString
            DispatchQueue.main.async()
            {
            if result == "Don Have Balance"
            {
                self.topup_creditbalance.text="0.00"
            }
            else
            {
                self.topup_creditbalance.text = result
                                         
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
            switch action.style
            {
            case .default : break
            case .cancel : break
            case .destructive : break
            }}))
            self.present(alert,animated: true, completion: nil)
        }
    }
    
    func MerchantInfo_Task_Topup(type:String,merchantid:String,qr_amount:String,lqrcode:String,qrcode:String)
        {
         if Reachability.isConnectedToNetwork()
         {
            let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/PostTopUp_MerchantInfo.aspx")
            guard let requestUrl = url2 else { fatalError() }
            var request = URLRequest(url: requestUrl)
            request.httpMethod = "POST"
            let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
            let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
            let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            let postString = "type=\(self.type)&merchantid=\(self.merchantid)&amount=\(self.qr_amount)&dynamicqrcode=\(self.lqrcode)&qrcode=\(self.qrcode)&Token=\(postStringencoding ?? "")";
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
                if dataString == "Invalid Merchant"
                 {
                    self.error_message.isHidden = false
                    self.error_message_label.isHidden = false
                    DispatchQueue.main.async()
                    {
                     let alert = UIAlertController(title: "Error #A0041", message: "Invalid Merchant" , preferredStyle : .alert)
                     alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                    switch action.style
                    {
                      case .default :
                      self.dismiss(animated: true, completion: nil)
                      self.app_error_message_log(error_message: "unsuccess topup Error #A0041 Invalid Merchant")
                      break
                      case .cancel : break
                      case .destructive : break
                    }}))
                     self.present(alert,animated: true, completion: nil)
                    }
                    }
                    else
                    {
                      self.topup_merchantname.text = "Transaction with merchant "+dataString;
                      self.merchant_name_single = dataString;
                      self.topup_amount.isEnabled = false
                      self.topup_amount.text = self.qr_amount
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

// MARK: - BarcodeScannerErrorDelegate

extension ScanTopUpQRCode: BarcodeScannerErrorDelegate {
  func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
    print(error)
  }
}

// MARK: - BarcodeScannerDismissalDelegate

extension ScanTopUpQRCode: BarcodeScannerDismissalDelegate {
  func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
   indicator = true
    self.dismiss(animated: true, completion: nil)
  }
}
