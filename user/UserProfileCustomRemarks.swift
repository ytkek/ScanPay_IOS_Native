//
//  UserProfileCustomRemarks.swift
//  user
//
//  Created by Kek on 31/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class UserProfileCustomRemarks: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var remarks_edit: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadpage()
        
        remarks_edit.delegate = self
        
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
               self.view.endEditing(true)
               return false
           }
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated:true,completion:nil)
    }
    func reloadpage()
       {
        if Reachability.isConnectedToNetwork(){
           let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/GetMyProfileList.aspx")
                  guard let requestUrl = url2 else { fatalError() }
                  // Prepare URL Request Object
                  var request = URLRequest(url: requestUrl)
                  request.httpMethod = "POST"
                   
                    let phoneinput = UserPreference.retreiveLoginID()
                  // HTTP Request Parameters which will be sent in HTTP Request Body
                    let postString = "LoginID=\(phoneinput)";
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
                              
                                self.remarks_edit.text = res.datarecords[0].ml_remarks
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
    @IBAction func save(_ sender: UIButton)
    {
         if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/PostUserProfile_Remarks.aspx")
                     guard let requestUrl = url2 else { fatalError() }
                     // Prepare URL Request Object
                     var request = URLRequest(url: requestUrl)
                     request.httpMethod = "POST"
                      
                       let phoneinput = UserPreference.retreiveLoginID()
                       let Remarks = remarks_edit.text
                      if let myString = Remarks {
                            let postString = "LoginID=\(phoneinput)&Remarks=\(myString)";
                      
                      // HTTP Request Parameters which will be sent in HTTP Request Body
                    
                       print(postString)
                     // Set HTTP Request Body
                     request.httpBody = postString.data(using: String.Encoding.utf8);
                     // Perform HTTP Request
              }
                     let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                             
                             // Check for Error
                             if let error = error {
                                 print("Error took place \(error)")
                                 return
                             }
                      
                             // Convert HTTP Response Data to a String
                            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                          print("Response data string:\n \(dataString)")
                              
                          if dataString == "SAVE PROFILE REMARKS SUCCESS"
                          {
                             DispatchQueue.main.async {
                              self.reloadpage()
                             
                              let alert = UIAlertController(title: "Alert", message: "Your Remarks have been saved", preferredStyle: UIAlertControllerStyle.alert)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
