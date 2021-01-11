//
//  UserProfileCustomEmail.swift
//  user
//
//  Created by Kek on 31/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class UserProfileCustomEmail: UIViewController {
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reloadpage()
    }
    @IBAction func back(_ sender: UIButton) {
      self.dismiss(animated:true,completion:nil)
    }
    func reloadpage()
       {
         if Reachability.isConnectedToNetwork()
         {
           let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/GetMyProfileList.aspx")
           guard let requestUrl = url2 else { fatalError() }
           var request = URLRequest(url: requestUrl)
           request.httpMethod = "POST"
           let phoneinput = UserPreference.retreiveLoginID()
           let postString = "LoginID=\(phoneinput)";
           request.httpBody = postString.data(using: String.Encoding.utf8);
           let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
           if let error = error
           {
              print("Error took place \(error)")
              return
            }
           if let data = data {
            do {
                let res = try JSONDecoder().decode(UserInformation.self, from: data)
                DispatchQueue.main.async()
                {
                    var value = res.datarecords[0].ml_email ?? ""
                    let realString = String(value)
                    self.email.text = realString
                }
                                
                }
                    catch let error
                {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
