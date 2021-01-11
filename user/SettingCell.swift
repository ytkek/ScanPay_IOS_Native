//
//  SettingCell.swift
//  user
//
//  Created by Kek on 13/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell
{

    @IBOutlet weak var qrcode: UIButton!
    @IBOutlet weak var profilename: UILabel!
    @IBOutlet weak var profileid: UILabel!
    override func awakeFromNib()
    {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        if Reachability.isConnectedToNetwork()
        {
        let url = URL(string: "https://www.myscanpay.com/v4/mobile/GetQRCode.aspx?c=\(UserPreference.retreiveLoginID())")
        DispatchQueue.main.async()
        {
            self.qrcode.downloadImage(from: url!)
        
        }
        let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/GetMyProfileList.aspx")
        guard let requestUrl = url2 else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let phoneinput = UserPreference.retreiveLoginID() ?? ""
        let postString = "LoginID=\(phoneinput)";
        print(postString)
        request.httpBody = postString.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error
        {
            print("Error took place \(error)")
            return
        }
        if let data = data
        {
            do {
                    let res = try JSONDecoder().decode(UserInformation.self, from: data)
                    print("ID :\(res.datarecords[0].ml_login ?? "")")
                    DispatchQueue.main.async()
                    {
                        self.profileid.text = "ID :\(res.datarecords[0].ml_login ?? "")"
                        self.profilename.text = res.datarecords[0].ml_Name
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
           
        }
        
    }
   
        
   
    
}
extension UIButton {
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
   func downloadImage(from url: URL) {
      getData(from: url) {
         data, response, error in
         guard let data = data, error == nil else {
            return
         }
         DispatchQueue.main.async()
        {
         
            self.setImage(UIImage(data: data), for: .normal)
         }
      }
   }
}
struct UserInformation: Codable {
    var datarecords: [records]
   

}

struct records :Codable {
    let ml_login : String?
    let ml_Name : String?
    let ml_password : String?
    let ml_email : String?
    let ml_hpno : String?
    let ml_gender  : String?
    let ml_nickname : String?
    let ml_remarks : String?
    let ml_dob : String?
    let ml_paymentpin : String?
    
}



