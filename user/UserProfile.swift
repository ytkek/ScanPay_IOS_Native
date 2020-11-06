//
//  UserProfile.swift
//  user
//
//  Created by Kek on 30/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class UserProfile: UIViewController {

    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var ID: UITextField!
    @IBOutlet weak var apppassword: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var nickname: UITextField!
    @IBOutlet weak var remarks: UITextField!
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var pinpassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        // reloadalldatapage();
        
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
         reloadalldatapage();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // reloadalldatapage();
    }
    
  public  func reloadalldatapage()
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
            
            let postString = "LoginID=\(phoneinput)&Token=\(postStringencoding ?? "")";
                print(postString)
            
              
            
                    
                    // HTTP Request Parameters which will be sent in HTTP
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
                                  print(res)
                                       self.fullname?.text = res.datarecords[0].ml_Name
                                                                 self.ID?.text = res.datarecords[0].ml_login
                                                                 self.apppassword?.text =
                                                                 res.datarecords[0].ml_password
                                                                 self.email?.text =
                                                                 res.datarecords[0].ml_email
                                                                 
                                                                 self.mobile?.text = "60\(res.datarecords[0].ml_hpno ?? "")"
                                                                 
                                                                 
                                    if res.datarecords[0].ml_gender == "M"
                                    {
                                        self.gender?.text = "male"
                                        
                                    }
                                    else if res.datarecords[0].ml_gender == "F"
                                    {
                                        self.gender?.text = "female"
                                    }
                                                                 
                                                                 self.nickname?.text =
                                                                     res.datarecords[0].ml_nickname
                                                                 self.remarks?.text =
                                                                     res.datarecords[0].ml_remarks
                                    self.dob?.text = self.convertDateFormat(inputDate:res.datarecords[0].ml_dob ?? "")
                                                                 self.pinpassword?.text =
                                                                     res.datarecords[0].ml_paymentpin
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
    func convertDateFormat(inputDate: String) -> String {

          let olDateFormatter = DateFormatter()
          olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
          let convertDateFormatter = DateFormatter()
          convertDateFormatter.dateFormat = "dd/MM/yyyy"
          let newDate = olDateFormatter.date(from: inputDate)
          let date = Date();
        return convertDateFormatter.string(from: newDate ?? date)
     }
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func fullname_onclick(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "userprofilecustomfullname") as? UserProfileCustomFullName
        {
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func ID_onclick(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "userprofilecustomid") as? UserProfileCustomID
               {
                   vc.modalPresentationStyle = .overFullScreen
                   vc.modalTransitionStyle = .crossDissolve
                   self.present(vc, animated: true, completion: nil)
               }
    }
    
    @IBAction func apppassword_onclick(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "userprofilecustomapppassword") as? UserProfileCustomAppPassword
               {
                   vc.modalPresentationStyle = .overFullScreen
                   vc.modalTransitionStyle = .crossDissolve
                   self.present(vc, animated: true, completion: nil)
               }
    }
    
    @IBAction func email_onclick(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "userprofilecustomemail") as? UserProfileCustomEmail
               {
                   vc.modalPresentationStyle = .overFullScreen
                   vc.modalTransitionStyle = .crossDissolve
                   self.present(vc, animated: true, completion: nil)
               }
    }
    
    @IBAction func mobile_onclick(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "userprofilecustommobile") as? UserProfileCustomMobile
               {
                   vc.modalPresentationStyle = .overFullScreen
                   vc.modalTransitionStyle = .crossDissolve
                   self.present(vc, animated: true, completion: nil)
               }
    }
    @IBAction func gender_onclick(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "userprofilecustomgender") as? UserProfileCustomGender
               {
                   vc.modalPresentationStyle = .overFullScreen
                   vc.modalTransitionStyle = .crossDissolve
                   self.present(vc, animated: true, completion: nil)
               }
    }
    @IBAction func nickname_onclick(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "userprofilecustomnickname") as? UserProfileCustomNickName
               {
                   vc.modalPresentationStyle = .overFullScreen
                   vc.modalTransitionStyle = .crossDissolve
                   self.present(vc, animated: true, completion: nil)
               }
    }
    @IBAction func remarks_onclick(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "userprofilecustomremarks") as? UserProfileCustomRemarks
               {
                   vc.modalPresentationStyle = .overFullScreen
                   vc.modalTransitionStyle = .crossDissolve
                   self.present(vc, animated: true, completion: nil)
               }
    }
    
    @IBAction func dob_onclick(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "userprofilecustomdob") as? UserProfileCustomDOB
               {
                   vc.modalPresentationStyle = .overFullScreen
                   vc.modalTransitionStyle = .crossDissolve
                   self.present(vc, animated: true, completion: nil)
               }
    }
    @IBAction func pin_onclick(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "userprofilecustompin") as? UserProfileCustomPin
               {
                   vc.modalPresentationStyle = .overFullScreen
                   vc.modalTransitionStyle = .crossDissolve
                   self.present(vc, animated: true, completion: nil)
               }
    }
    

}


