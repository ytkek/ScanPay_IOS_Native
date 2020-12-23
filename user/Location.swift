//
//  Location.swift
//  user
//
//  Created by Kek on 23/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class Location: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    var othersList = [merchantrecords]()
    var MerchantList = [merchantrecords]()
    var exampleothers = 0
    let animals: [String] = ["MyScanPay", "Cow", "Camel", "Sheep", "Goat"]

    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    
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
                                      UIApplication.shared.statusBarView?.backgroundColor = .white
                                  }
                   self.view.frame.origin.y = 30
                                                    
                   }
                   else
                  {
                     UIApplication.shared.statusBarView?.backgroundColor = .white
                       self.view.frame.origin.y = 0
                                                       
                                                       
                  }
               }
              
           }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.exampleothers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
          let cell:LocationTableViewCell = self.tableview.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! LocationTableViewCell
               // set the text from the data model
        cell.celltext?.text = "MyscanPay"
        cell.cellimage?.image = UIImage (named: "Image")
        cell.celldetail?.text = "06-01, Jalan Austin Perdana 2/23, Taman Mount Austin 81100, Johor Bahru"

               return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             var cellHeight:CGFloat = CGFloat()

            
                 cellHeight = 200
           
             return cellHeight
         }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "findmerchantdetail") as! FindMerchantDetail
                  nextViewController.findmerchant_companyname = self.othersList[indexPath.row].m_companyname!;
                  nextViewController.findmerchant_profileimagepath = self.othersList[indexPath.row].m_profileimagepath!
                  nextViewController.findmerchant_profilefilename = (self.othersList[indexPath.row].m_profilefilename ?? "")
                  nextViewController.findmerchant_photofilename1 = (self.othersList[indexPath.row].m_photofilename1 ?? "")
                  nextViewController.findmerchant_photofilename2 = (self.othersList[indexPath.row].m_photofilename2 ?? "")
                  nextViewController.findmerchant_photofilename3 = (self.othersList[indexPath.row].m_photofilename3 ?? "")
          
                  nextViewController.findmerchant_address1 = self.othersList[indexPath.row].m_address1!
                  nextViewController.findmerchant_address2 = self.othersList[indexPath.row].m_address2!
                  nextViewController.findmerchant_address3 = self.othersList[indexPath.row].m_address3!
                  nextViewController.findmerchant_address4 = self.othersList[indexPath.row].m_address4!
                  nextViewController.findmerchant_telcc =
                      self.othersList[indexPath.row].m_telcc!
                  nextViewController.findmerchant_telac =
                      self.othersList[indexPath.row].m_telac!
                  nextViewController.findmerchant_telno =
                      self.othersList[indexPath.row].m_telno!
                   nextViewController.findmerchant_mobileno =
                      self.othersList[indexPath.row].m_mobileno!
                  nextViewController.findmerchant_email =
                      self.othersList[indexPath.row].m_email!
                  nextViewController.findmerchant_country =
                      self.othersList[indexPath.row].m_country!
                  nextViewController.findmerchant_state =
                      self.othersList[indexPath.row].m_state!
                  nextViewController.findmerchant_city =
                      self.othersList[indexPath.row].m_city!
                  nextViewController.findmerchant_url =
                      self.othersList[indexPath.row].m_url!
                  nextViewController.findmerchant_longtitude =
                      self.othersList[indexPath.row].m_longtitude!
                  nextViewController.findmerchant_latitude =
                      self.othersList[indexPath.row].m_latitude!
                  nextViewController.findmerchant_businesshour =
                      self.othersList[indexPath.row].m_businesshour!
                  nextViewController.findmerchant_remarks =
                      self.othersList[indexPath.row].m_remarks!
                  nextViewController.modalPresentationStyle = .fullScreen
                  present(nextViewController,animated:true,completion:nil)
     }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
 print("You tapped cell number \(indexPath.row).")
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableview.register(LocationTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()

        // This view controller itself will provide the delegate methods and row data for the table view.
        tableview.delegate = self
        tableview.dataSource = self
        reloadalldatapage()
        // Do any additional setup after loading the view.
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
    
    public  func reloadalldatapage()
         {
          if Reachability.isConnectedToNetwork(){
             let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/GetAllMerchantList.aspx")
                         guard let requestUrl = url2 else { fatalError() }
                         // Prepare URL Request Object
                         var request = URLRequest(url: requestUrl)
                         request.httpMethod = "POST"
            
            let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
            
             let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
            
            let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                                      
            
            
            let postString = "Token=\(postStringencoding ?? "")";
                print(postString)
                          
            request.httpBody = postString.data(using: String.Encoding.utf8);
                         // Set HTTP Request Body
                         //request.httpBody = postString.data(using: String.Encoding.utf8);
                         // Perform HTTP Request
                         let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                                 
                                 // Check for Error
                                 if let error = error {
                                     print("Error took place \(error)")
                                     return
                                 }
                          
                                 // Convert HTTP Response Data to a String
                          if let data = data{
                              
                                      do {
                                        
                                         let res = try JSONDecoder().decode(FindMerchantInformation.self, from: data)
                                      
                                          self.MerchantList = res.datarecords
                                          for n in 0..<(res.datarecords.count)
                                          {
                                             
                                             
                                               if res.datarecords[n].m_id == 60
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

}
