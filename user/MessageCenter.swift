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
    let cellReuseIdentifier = "cell"
    var MessageList = [messagerecords]()
    
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.MessageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MessageCenterTableViewCell = self.tableview.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MessageCenterTableViewCell
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
   
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
        if Reachability.isConnectedToNetwork()
        {
          let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/GetUserMessageList.aspx")
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
                return
            }
            if let data = data
            {
               do
               {
                  let res = try JSONDecoder().decode(MessageInformation.self, from: data)
                   self.MessageList = res.datarecords
                    DispatchQueue.main.async()
                    {
                        self.tableview.reloadData()
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

