//
//  MessageCenter.swift
//  user
//
//  Created by Kek on 24/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class MessageCenter: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableview: UITableView!
    
    let animals: [String] = ["MyScanPay", "24 HRS challenge", "One more day to go", "Free Top Up", "Notification"]
    
      let animals2: [String] = ["4/8/18: Today is the day??", "Want to know what goodies", "It's tomorrow??!! Try new items on", "Visit District 9 Cafe Bar @", "For enquiries, please"]
    

    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
     var MessageList = [messagerecords]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.MessageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MessageCenterTableViewCell = self.tableview.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MessageCenterTableViewCell
               // set the text from the data model
        cell.celltitle?.text = self.MessageList[indexPath.row].nob_title
        cell.cellimage?.image = UIImage (named: "messagecenter")
        cell.celldetail?.text = self.MessageList[indexPath.row].nob_message

               return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
               var cellHeight:CGFloat = CGFloat()

              
                   cellHeight = 100
             
               return cellHeight
           }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "messagecenterdetail") as! MessageCenterDetail
        nextViewController.date = self.MessageList[indexPath.row].nob_publishdate ?? ""
        nextViewController.m_title = self.MessageList[indexPath.row].nob_title ?? ""
        nextViewController.message = self.MessageList[indexPath.row].nob_message ?? ""
        
         nextViewController.modalPresentationStyle = .fullScreen
         present(nextViewController,animated:true,completion:nil)
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    print("You tapped cell number \(indexPath.row).")
          }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        reloadalldatapage()
        tableview.delegate = self
        tableview.dataSource = self
    }
    

    @IBAction func back(_ sender: UIButton) {
          self.dismiss(animated: true, completion: nil)    }
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
          let url2 = URL(string: "https://www.myscanpay.com/V4/mobile_native_api/GetUserMessageList.aspx")
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
                                   
                                    let res = try JSONDecoder().decode(MessageInformation.self, from: data)
                                    
                                   // let self.MessageList = res.datarecords.sorted
                                    self.MessageList = res.datarecords
                                    
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
struct MessageInformation: Codable {
    var datarecords: [messagerecords]
   
    init(datarecords: [messagerecords]){
        self.datarecords = datarecords
    }

}

struct messagerecords :Codable {
    let nob_id : Int?
    let nob_title  : String?
    let nob_message : String?
    let nob_publishdate : String?
    
    
}

