//
//  DiscoveryCell.swift
//  user
//
//  Created by Kek on 13/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit
import DropDown
import SDWebImage
import CryptoSwift

class DiscoveryCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    var test = "wtf"
    
    let animals: [String] = ["MyScanPay", "24 HRS challenge", "One more day to go", "Free Top Up", "Notification"]
       
         let animals2: [String] = ["4/8/18: Today is the day??", "Want to know what goodies", "It's tomorrow??!! Try new items on", "Visit District 9 Cafe Bar @", "For enquiries, please"]
    
    @IBOutlet weak var discoveryselection: UIButton!
    let dropDown = DropDown()
    
    
    weak var viewController: UIViewController?;    let cellReuseIdentifier = "cell"
    let picdomain = "https://www.myscanpay.com/"
    var urlString = ""
    var DiscoveryList = [discoveryrecords]()
    var indicator = false
    var foodandbeverageList = [discoveryrecords]()
    var myScanPayList = [discoveryrecords]()
    var newhiringList = [discoveryrecords]()
    var retailList = [discoveryrecords]()
     var mobiletruckList = [discoveryrecords]()
    var serviceList = [discoveryrecords]()
    var othersList = [discoveryrecords]()
    var selectionint = 0
    var calculatecount = 0
    
    var exampleall = 0
    var examplefood = 0
    var examplemyscanpay = 0
    var examplenewhiring = 0
    var exampleretail = 0
    var examplemobiletruck = 0
    var exampleservice = 0
    var exampleothers = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if indicator == true
        {
            self.calculatecount = self.exampleall
        }
        else
        {
            if self.selectionint == 0
            {
           // self.calculatecount = self.examplefood
            self.calculatecount = self.examplemyscanpay
            }
        if self.selectionint == 1
        {
           
            self.calculatecount = self.examplefood
        }
        if self.selectionint == 2
               {
                  
                   self.calculatecount = self.exampleretail
               }
        if self.selectionint == 3
               {
                  
                   self.calculatecount = self.exampleservice
               }
        if self.selectionint == 4
               {
                  
                   self.calculatecount = self.examplenewhiring
               }
        if self.selectionint == 5
               {
                  
                   self.calculatecount = self.examplemobiletruck
               }
            if self.selectionint == 6
            {
           
                self.calculatecount = self.exampleothers
            }
        }
        return self.calculatecount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:DiscoveryListView =
            self.tableview.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! DiscoveryListView
               // set the text from the data model
        cell.viewController = self.viewController
         cell.selectionStyle = .none
        
        if self.indicator == true
        {
            let transformerprofile = SDImageResizingTransformer(size: CGSize(width: 1000, height: 500), scaleMode: .fill)
            cell.celltitle?.text = self.DiscoveryList[indexPath.row].lop_name
                              cell.celldetail?.text = self.DiscoveryList[indexPath.row].lop_description
                              
                              urlString = self.picdomain + (self.DiscoveryList[indexPath.row].lop_imagepath ?? "") +
                                  (self.DiscoveryList[indexPath.row].lop_image ?? "")
                              //urlString = urlString.replacingOccurrences(of: " ", with: "")
                               urlString = (urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
                              cell.cellimage?.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "messagecenter"), context: [.imageTransformer: transformerprofile])
            DiscoveryListView.moreurl.append(self.DiscoveryList[indexPath.row].lop_externallink ?? "") 
            DiscoveryListView.shareurl.append(self.DiscoveryList[indexPath.row].lop_externallink ?? "")
            cell.indexpath = indexPath
        }
        else
        {
            if self.selectionint == 0
                          {
                               let transformerprofile = SDImageResizingTransformer(size: CGSize(width: 1000, height: 500), scaleMode: .fill)
                           cell.celltitle?.text = self.myScanPayList[indexPath.row].lop_name
                              cell.celldetail?.text = self.myScanPayList[indexPath.row].lop_description
                              
                              urlString = self.picdomain + (self.myScanPayList[indexPath.row].lop_imagepath ?? "") +
                                  (self.myScanPayList[indexPath.row].lop_image ?? "")
                              //urlString = urlString.replacingOccurrences(of: " ", with: "")
                               urlString = (urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
                              cell.cellimage?.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "messagecenter"), context: [.imageTransformer: transformerprofile])
                            DiscoveryListView.moreurl.append(self.myScanPayList[indexPath.row].lop_externallink ?? "")
                             DiscoveryListView.shareurl.append(self.myScanPayList[indexPath.row].lop_externallink ?? "")
                             cell.indexpath = indexPath
                              
                              
                          }
                   else if self.selectionint == 1
                   {
                        let transformerprofile = SDImageResizingTransformer(size: CGSize(width: 1000, height: 500), scaleMode: .fill)
                       cell.celltitle?.text = self.foodandbeverageList[indexPath.row].lop_name
                       cell.celldetail?.text = self.foodandbeverageList[indexPath.row].lop_description
                       
                       urlString = self.picdomain + (self.foodandbeverageList[indexPath.row].lop_imagepath ?? "") +
                           (self.foodandbeverageList[indexPath.row].lop_image ?? "")
                       //urlString = urlString.replacingOccurrences(of: " ", with: "")
                        urlString = (urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
                       cell.cellimage?.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "messagecenter"), context: [.imageTransformer: transformerprofile])
                     DiscoveryListView.moreurl.append(self.foodandbeverageList[indexPath.row].lop_externallink ?? "")
                     DiscoveryListView.shareurl.append(self.foodandbeverageList[indexPath.row].lop_externallink ?? "")
                     cell.indexpath = indexPath
                       
                       
                   }
                   
                   else if self.selectionint == 2
                         {
                              let transformerprofile = SDImageResizingTransformer(size: CGSize(width: 1000, height: 500), scaleMode: .fill)
                           cell.celltitle?.text = self.retailList[indexPath.row].lop_name
                             cell.celldetail?.text = self.retailList[indexPath.row].lop_description
                             
                             urlString = self.picdomain + (self.retailList[indexPath.row].lop_imagepath ?? "") +
                                 (self.retailList[indexPath.row].lop_image ?? "")
                             //urlString = urlString.replacingOccurrences(of: " ", with: "")
                              urlString = (urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
                             cell.cellimage?.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "messagecenter"), context: [.imageTransformer: transformerprofile])
                            DiscoveryListView.moreurl.append(self.retailList[indexPath.row].lop_externallink ?? "")
                            DiscoveryListView.shareurl.append(self.retailList[indexPath.row].lop_externallink ?? "")
                            cell.indexpath = indexPath
                             
                             
                         }
               else if self.selectionint == 3
                           {
                                let transformerprofile = SDImageResizingTransformer(size: CGSize(width: 1000, height: 500), scaleMode: .fill)
                             cell.celltitle?.text = self.serviceList[indexPath.row].lop_name
                               cell.celldetail?.text = self.serviceList[indexPath.row].lop_description
                               
                               urlString = self.picdomain + (self.serviceList[indexPath.row].lop_imagepath ?? "") +
                                   (self.serviceList[indexPath.row].lop_image ?? "")
                               //urlString = urlString.replacingOccurrences(of: " ", with: "")
                                urlString = (urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
                               cell.cellimage?.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "messagecenter"), context: [.imageTransformer: transformerprofile])
                            DiscoveryListView.moreurl.append(self.serviceList[indexPath.row].lop_externallink ?? "")
                            DiscoveryListView.shareurl.append(self.serviceList[indexPath.row].lop_externallink ?? "")
                            cell.indexpath = indexPath
                                                        
                               
                               
                           }
                   else if self.selectionint == 4
                                 {
                                      let transformerprofile = SDImageResizingTransformer(size: CGSize(width: 1000, height: 500), scaleMode: .fill)
                                   cell.celltitle?.text = self.newhiringList[indexPath.row].lop_name
                                     cell.celldetail?.text = self.newhiringList[indexPath.row].lop_description
                                     
                                     urlString = self.picdomain + (self.newhiringList[indexPath.row].lop_imagepath ?? "") +
                                         (self.newhiringList[indexPath.row].lop_image ?? "")
                                     //urlString = urlString.replacingOccurrences(of: " ", with: "")
                                      urlString = (urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
                                     cell.cellimage?.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "messagecenter"), context: [.imageTransformer: transformerprofile])
                    DiscoveryListView.moreurl.append(self.newhiringList[indexPath.row].lop_externallink ?? "")
                    DiscoveryListView.shareurl.append(self.newhiringList[indexPath.row].lop_externallink ?? "")
                    cell.indexpath = indexPath
                                     
                                     
                                 }
                   else if self.selectionint == 5
                                       {
                                            let transformerprofile = SDImageResizingTransformer(size: CGSize(width: 1000, height: 500), scaleMode: .fill)
                                           cell.celltitle?.text = self.mobiletruckList[indexPath.row].lop_name
                                           cell.celldetail?.text = self.mobiletruckList[indexPath.row].lop_description
                                           
                                           urlString = self.picdomain + (self.mobiletruckList[indexPath.row].lop_imagepath ?? "") +
                                               (self.mobiletruckList[indexPath.row].lop_image ?? "")
                                           //urlString = urlString.replacingOccurrences(of: " ", with: "")
                                            urlString = (urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
                                           cell.cellimage?.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "messagecenter"), context: [.imageTransformer: transformerprofile])
                                DiscoveryListView.moreurl.append(self.mobiletruckList[indexPath.row].lop_externallink ?? "")
                                DiscoveryListView.shareurl.append(self.mobiletruckList[indexPath.row].lop_externallink ?? "")
                                    cell.indexpath = indexPath
                                           
                                           
                                       }
                         else if self.selectionint == 6
                                       {
                                            let transformerprofile = SDImageResizingTransformer(size: CGSize(width: 1000, height: 500), scaleMode: .fill)
                                           cell.celltitle?.text = self.othersList[indexPath.row].lop_name
                                           cell.celldetail?.text = self.othersList[indexPath.row].lop_description
                                           
                                           urlString = self.picdomain + (self.othersList[indexPath.row].lop_imagepath ?? "") +
                                               (self.othersList[indexPath.row].lop_image ?? "")
                                           //urlString = urlString.replacingOccurrences(of: " ", with: "")
                                            urlString = (urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
                                           cell.cellimage?.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "messagecenter"), context: [.imageTransformer: transformerprofile])
                            DiscoveryListView.moreurl.append(self.othersList[indexPath.row].lop_externallink ?? "")
                            DiscoveryListView.shareurl.append(self.othersList[indexPath.row].lop_externallink ?? "")
                            cell.indexpath = indexPath
                                           
                                           
                                       }
        }
       
              
        
               return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
               var cellHeight:CGFloat = CGFloat()

              
                   cellHeight = 350
             
               return cellHeight
           }
    
    
    
   
    
    @IBAction func viewall(_ sender: UIButton) {
       
        
        DispatchQueue.main.async()
                       {
                       
                        DiscoveryListView.moreurl.removeAll()
                        DiscoveryListView.shareurl.removeAll()
                          self.DiscoveryList.removeAll()
                           self.foodandbeverageList.removeAll()
                           self.myScanPayList.removeAll()
                           self.newhiringList.removeAll()
                           self.retailList.removeAll()
                           self.mobiletruckList.removeAll()
                           self.serviceList.removeAll()
                           self.othersList.removeAll()
                          
                          self.exampleall = 0
                          self.examplefood = 0
                           self.examplemyscanpay = 0
                           self.examplenewhiring = 0
                          self.exampleretail = 0
                          self.examplemobiletruck = 0
                           self.exampleservice = 0
                           self.exampleothers = 0
                         self.indicator = true
                        self.reloadalldatapage()
                       //self.tableview.reloadData()
                       
                       
                       }
    }
    
   override func layoutSubviews() {
        super.layoutSubviews()
    
    
    
    tableview.delegate = self
    tableview.dataSource = self
   
    discoveryselection.backgroundColor = UIColor.white
    

           // The view to which the drop down will appear on
           dropDown.anchorView = discoveryselection // UIView or UIBarButtonItem

           // The list of items to display. Can be changed dynamically
           dropDown.dataSource = ["MySCANPAY", "FOOD AND BEVERAGE", "RETAIL SHOPS","SERVICES","NEW HIRING","MOBILE TRUCK", "OTHER GROUPS"]
           // dropDown.selectRow(at: 0)
            self.discoveryselection.setTitle("MySCANPAY", for: .normal)
            self.indicator = true
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.selectionint = index;
                self.discoveryselection.setTitle(item, for: .normal)
                DispatchQueue.main.async()
                {
                    
                    DiscoveryListView.moreurl.removeAll()
                    DiscoveryListView.shareurl.removeAll()
                     self.DiscoveryList.removeAll()
                     self.foodandbeverageList.removeAll()
                     self.myScanPayList.removeAll()
                     self.newhiringList.removeAll()
                     self.retailList.removeAll()
                     self.mobiletruckList.removeAll()
                     self.serviceList.removeAll()
                     self.othersList.removeAll()
                    
                    self.exampleall = 0
                    self.examplefood = 0
                     self.examplemyscanpay = 0
                     self.examplenewhiring = 0
                    self.exampleretail = 0
                    self.examplemobiletruck = 0
                     self.exampleservice = 0
                     self.exampleothers = 0
                    self.indicator = false
                    self.reloadalldatapage()
                    
                }
           }
            	
    
    }
    
    
     public  func reloadalldatapage()
           {
             if Reachability.isConnectedToNetwork(){
               let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/GetAllDiscoveryList.aspx")
                           guard let requestUrl = url2 else { fatalError() }
                           // Prepare URL Request Object
                           var request = URLRequest(url: requestUrl)
                           request.httpMethod = "POST"
                            
                    let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
                
                
                let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
                   
                           // Set HTTP Request Body
                           // Perform HTTP Request
                
                let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                            let postString = "Token=\(postStringencoding ?? "")";
                            print(postString)
               
                // Set HTTP Request Body
                            request.httpBody = postString.data(using: String.Encoding.utf8);

               
                           let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                                   
                                   // Check for Error
                                   if let error = error {
                                       print("Error took place \(error)")
                                       return
                                   }
                            
                                   // Convert HTTP Response Data to a String
                            if let data = data {
                                    do {
                                          
                                       
                                        let res = try JSONDecoder().decode(DiscoveryInformation.self, from: data)
                                        print(res)
                                        self.DiscoveryList = res.datarecords
                                        for n in 0..<(res.datarecords.count)
                                        {
                                            self.exampleall = self.exampleall + 1
                                            if res.datarecords[n].lop_groupid == 5
                                            {
                                                self.examplemyscanpay = self.examplemyscanpay + 1
                                                self.myScanPayList.append(res.datarecords[n])
                                            }
                                            if res.datarecords[n].lop_groupid == 1
                                            {
                                                self.examplefood = self.examplefood + 1
                                                self.foodandbeverageList.append(res.datarecords[n])
                                                
                                            }
                                            if res.datarecords[n].lop_groupid == 2
                                            {
                                                self.exampleretail = self.exampleretail + 1
                                                self.retailList.append(res.datarecords[n])
                                            }
                                            if res.datarecords[n].lop_groupid == 3
                                            {
                                                self.exampleservice = self.exampleservice + 1
                                                self.serviceList.append(res.datarecords[n])
                                            }
                                            if res.datarecords[n].lop_groupid == 6
                                            {
                                                self.examplenewhiring = self.examplenewhiring + 1
                                                self.newhiringList.append(res.datarecords[n])
                                            }
                                            if res.datarecords[n].lop_groupid == 7
                                            {
                                                self.examplemobiletruck = self.examplemobiletruck + 1
                                                self.mobiletruckList.append(res.datarecords[n])
                                            }
                                            if res.datarecords[n].lop_groupid == 4
                                            {
                                                self.exampleothers = self.exampleothers + 1
                                                self.othersList.append(res.datarecords[n])
                                            }
                                            
                                        }
                                         DispatchQueue.main.async() {
                                         self.tableview.reloadData()
                                              
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
    
    @IBAction func discoveryselection_click(_ sender: UIButton) {
        dropDown.show()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       reloadalldatapage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func aesEncrypt(text: String , key: String ) -> String{
       let cleartext = text
      //let byteText = cleartext.data(using: String.Encoding.utf8)?.bytes
     let byteText:[UInt8] = Array(cleartext.utf8)
     let keyBytes = [UInt8](repeating: 0, count:16)
    // let byteKey :[UInt8] = [UInt8](key.data(using:String.Encoding.utf8)!.bytes)
     let byteKey:[UInt8] = Array(key.utf8)
     //let iv = key.data(using:String.Encoding.utf8)!.bytes
     
     var len = byteKey.count

     if (len > keyBytes.count)
     {
     len = keyBytes.count
     }

    // let bytekeyarray = Array(byteKey[0 ..< 0+len])
     let slice = byteKey[0 ..< 0+len]
     let bytekeyarray = Array(slice)
     do {
         let aes = try AES(key: bytekeyarray, blockMode: CBC(iv:bytekeyarray), padding: .pkcs7)
         let encrypted : [UInt8] = try aes.encrypt(byteText)
         let data = NSData(bytes: encrypted,length: encrypted.count)
         //let encData  = Data(bytes: encrypted,count: Int(encrypted.count))
         
         let base64String : String = data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue:0))
         return "\(base64String)"
        // print("\(base64String)")
     }
     catch
     {
         return ""
     }
    
     }
   
}

extension String{
    
   

    
    func Base64toUTF8() -> String {
        let data = NSData.init(base64Encoded: self, options: []) ?? NSData()
        return String(data: data as Data ,encoding: String.Encoding.utf8) ?? ""
    }
    
}


struct DiscoveryInformation: Codable {
    var datarecords: [discoveryrecords]
   
    init(datarecords: [discoveryrecords]){
        self.datarecords = datarecords
    }
}
struct discoveryrecords :Codable {
    let lop_merchanid : String?
    let lop_groupid : Int?
    let lop_name : String?
    let lop_description : String?
    let lop_image : String?
    let lop_imagepath : String?
    let lop_externallink : String?
    
    
}

