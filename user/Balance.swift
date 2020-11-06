//
//  Balance.swift
//  user
//
//  Created by Kek on 30/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class Balance: UIViewController,UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var datefrom: UITextField!
    
    @IBOutlet weak var dateto: UITextField!
    @IBOutlet weak var transaction_table: UITableView!
    private var datepicker : UIDatePicker?
    private var datepicker2 : UIDatePicker?
    
    
    @IBOutlet weak var total_balance_label: UILabel!
    @IBOutlet weak var dailylimit_label: UILabel!
    
    @IBOutlet weak var dailybalance_label: UILabel!
    var balancetype = ""
    let dateFrominputString = ""
    
    
    var BalanceList = [balancerecords]()
    let animals: [String] = ["2020/03/05"]
       
         let animals2: [String] = ["05:13:38 pm"]
     let animals3: [String] = ["revpay"]
     let animals4: [String] = ["MyScanPay"]
     let animals5: [String] = ["1.00"]
    
    let cellReuseIdentifier = "cell"
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
        return self.BalanceList.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell:BalanceTableViewCell = self.transaction_table.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! BalanceTableViewCell
                  // set the text from the data model
        let dateFormatter = DateFormatter()
       
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        
        //dateFormatter.dateFormat = "E MMM d yyyy HH:mm:ss 'GMT'ZZZ"
        let dateFrominputString = dateFormatter.date(from:self.BalanceList[indexPath.row].la_createdt ?? "")
        
        if dateFrominputString == nil
        {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let dateFrominputString2 = dateFormatter.date(from:self.BalanceList[indexPath.row].la_createdt ?? "")
                dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss a"
                 
                   
                   cell.celldate?.text = dateFormatter.string(from: dateFrominputString2!)
        }
        else
        {
            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss a"
        
            
            cell.celldate?.text = dateFormatter.string(from: dateFrominputString!)
        }
       
       //dateFormatter.dateFormat = "yyyy/MM/dd hh:mm:ss a"
       // dateFormatter.locale = tempLocale
        
       // cell.celldate?.text = dateFormatter.string(from: dateFrominputString!)
        if self.BalanceList[indexPath.row].la_type == "revtopup"
        {
            balancetype = "Reversal Top Up"
        }
        else if self.BalanceList[indexPath.row].la_type == "topup"
        {
            balancetype = "Top Up"
        }
        else if self.BalanceList[indexPath.row].la_type == "revpay"
        {
            balancetype = "Reversal Payment"
        }
        else if self.BalanceList[indexPath.row].la_type == "pay"
        {
            balancetype = "Payment"
        }
        
        cell.celltype?.text = "\(balancetype ?? "")"
        cell.cellreference?.text = "\(self.BalanceList[indexPath.row].la_ref ?? "")"
        var myString = "\(self.BalanceList[indexPath.row].la_amount ?? 0)"
        if myString.contains("-"){
            myString = myString.replacingOccurrences(of: "-", with: "")
            cell.cellamount?.textColor = UIColor.red
            
        }
        else
        {
            cell.cellamount?.textColor = UIColor.blue
        }
        
        let balanceamount = Double(myString)
        cell.cellamount?.text = String(format:"%.2f",balanceamount ?? 0)
                  return cell
       }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                  var cellHeight:CGFloat = CGFloat()

                 
                      cellHeight = 80
                
                  return cellHeight
              }
       
       func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       print("You tapped cell number \(indexPath.row).")
             }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBalanceCredit()
        getDailylimit()
        getDailybalance()
        getcurrentdate_statement()

        transaction_table.delegate = self
        transaction_table.dataSource = self
        datepicker = UIDatePicker()
        datepicker?.datePickerMode = .date
        datepicker?.addTarget(self, action: #selector(Balance.dateChanged(datePicker:)), for: .valueChanged)
        datepicker2 = UIDatePicker()
               datepicker2?.datePickerMode = .date
               datepicker2?.addTarget(self, action: #selector(Balance.dateChanged2(datePicker:)), for: .valueChanged)
        
        datefrom.inputView = datepicker
        dateto.inputView = datepicker2
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Balance.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
    
        
        
        
    }
    @IBAction func Search(_ sender: UIButton) {
        getsearchdate_statement()
    }
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil) 
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer)
    {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        datefrom.text = dateFormatter.string(from: datePicker.date)
        //view.endEditing(true)
    }
    @objc func dateChanged2(datePicker: UIDatePicker){
           
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd/MM/yyyy"
           dateto.text = dateFormatter.string(from: datePicker.date)
          // view.endEditing(true)
       }
    
    public  func getBalanceCredit()
    {
          if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/GetBalance_TotalCredit.aspx")
                    guard let requestUrl = url2 else { fatalError() }
                    // Prepare URL Request Object
                    var request = URLRequest(url: requestUrl)
                    request.httpMethod = "POST"
                     
        let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
                      
                      
                      let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
                         
                                 // Set HTTP Request Body
                                 // Perform HTTP Request
                      
                      let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            
                      let phoneinput = UserPreference.retreiveLoginID()
                    // HTTP Request Parameters which will be sent in HTTP Request Body
                      let postString = "LoginID=\(phoneinput)&Token=\(postStringencoding ?? "")";
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
                          if let data = data, let dataString = String(data: data, encoding: .utf8) {
                                                                              print("Response data string:\n \(dataString)")
                                                    
                                                                          DispatchQueue.main.async()
                                                                        {
                                                                            self.total_balance_label.text = "RM \(dataString)"                                            }
                                }
                            }
                    task.resume()
        }
        else
          {
                        let alert = UIAlertController(title: "Error", message: "Internet Connection Failed" , preferredStyle : .alert)
                       alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                       switch action.style{
                                                                  
                       case .default : break
                                                                     
                       case .cancel : break
                                                                     
                       case .destructive : break
                                                                 
                       }}))
                       self.present(alert,animated: true, completion: nil)
          }
                      
    }
    
    public  func getDailylimit()
    {
        if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/GetBalance_DailyLimit.aspx")
                           guard let requestUrl = url2 else { fatalError() }
                           // Prepare URL Request Object
                           var request = URLRequest(url: requestUrl)
                           request.httpMethod = "POST"
    let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
                  
                  
                  let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
                     
                             // Set HTTP Request Body
                             // Perform HTTP Request
                  
                  let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                            
        let phoneinput = UserPreference.retreiveLoginID()
                           // HTTP Request Parameters which will be sent in HTTP Request Body
                             let postString = "LoginID=\(phoneinput)&Token=\(postStringencoding ?? "")";
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
                                 if let data = data, let dataString = String(data: data, encoding: .utf8) {
                                                                                     print("Response data string:\n \(dataString)")
                                                           
                                                                                 DispatchQueue.main.async()
                                                                               {
                                                                                self.dailylimit_label.text = "RM \(dataString)"                                            }
                                       }
                                   }
                           task.resume()
                }
                else
                 {
                               let alert = UIAlertController(title: "Error", message: "Internet Connection Failed" , preferredStyle : .alert)
                              alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                              switch action.style{
                                                                         
                              case .default : break
                                                                            
                              case .cancel : break
                                                                            
                              case .destructive : break
                                                                        
                              }}))
                              self.present(alert,animated: true, completion: nil)
                 }
        
    }
    public  func getDailybalance()
    {
         if Reachability.isConnectedToNetwork(){
        let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/GetBalance_DailyExp.aspx")
                           guard let requestUrl = url2 else { fatalError() }
                           // Prepare URL Request Object
                           var request = URLRequest(url: requestUrl)
                           request.httpMethod = "POST"
                    let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
                  
                  
                  let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
                     
                             // Set HTTP Request Body
                             // Perform HTTP Request
                  
                  let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            
            
                             let phoneinput = UserPreference.retreiveLoginID()
                           // HTTP Request Parameters which will be sent in HTTP Request Body
                             let postString = "LoginID=\(phoneinput)&Token=\(postStringencoding ?? "")";
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
                                 if let data = data, let dataString = String(data: data, encoding: .utf8) {
                                                                                     print("Response data string:\n \(dataString)")
                                                           
                                                                                 DispatchQueue.main.async()
                                                                               {
                                                                             //   self.dailybalance_label.text = "RM \(dataString)"
                                                                                
                                    }
                                       }
                                   }
                           task.resume()
        }
        else
         {
            let alert = UIAlertController(title: "Error", message: "Internet Connection Failed" , preferredStyle : .alert)
                alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                switch action.style{
                                                                                    
                case .default : break
                                                                                       
                case .cancel : break
                                                                                       
                case .destructive : break
                                                                                   
                }}))
                self.present(alert,animated: true, completion: nil)
        }
        
    }
    public  func getcurrentdate_statement()
       {
         if Reachability.isConnectedToNetwork(){
           let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/GetBalance_CurrentDate_Statement.aspx")
                              guard let requestUrl = url2 else { fatalError() }
                              // Prepare URL Request Object
                              var request = URLRequest(url: requestUrl)
                              request.httpMethod = "POST"
            
                     let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
                      
                      
                      let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
                         
                                 // Set HTTP Request Body
                                 // Perform HTTP Request
                      
                      let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                               
                                let phoneinput = UserPreference.retreiveLoginID()
                              // HTTP Request Parameters which will be sent in HTTP Request Body
                    let postString = "LoginID=\(phoneinput)&Token=\(postStringencoding ?? "")";
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
                                          
                                         
                                        let res = try JSONDecoder().decode(BalanceInformation.self, from: data)
                                          
                                        self.BalanceList = res.datarecords
                                        print("\(res.datarecords)")
                                         DispatchQueue.main.async() {
                                            self.transaction_table.reloadData()
                                              
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
            let alert = UIAlertController(title: "Error", message: "Internet Connection Failed" , preferredStyle : .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
            switch action.style{
                                                                                
            case .default : break
                                                                                   
            case .cancel : break
                                                                                   
            case .destructive : break
                                                                               
            }}))
            self.present(alert,animated: true, completion: nil)
        }
                                
       }
    
    public  func getsearchdate_statement()
          {
            if Reachability.isConnectedToNetwork(){
              let url2 = URL(string: "https://www.myscanpay.com/V5/mobile_native_api/GetBalance_SearchDate_Statement.aspx")
                                 guard let requestUrl = url2 else { fatalError() }
                                 // Prepare URL Request Object
                                 var request = URLRequest(url: requestUrl)
                                 request.httpMethod = "POST"
    let value =  "\(UserPreference.retreiveLoginID())+\(UserPreference.retreiveLoginPassword())"
    
    
    let Encryptedvalue = DiscoveryCell.aesEncrypt(text : value,key: "@McQfTjWnZq4t7w!")
       
               // Set HTTP Request Body
               // Perform HTTP Request
    
    let postStringencoding = Encryptedvalue.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                
                                   let phoneinput = UserPreference.retreiveLoginID()
                                 // HTTP Request Parameters which will be sent in HTTP Request Body
            let postString = "LoginID=\(phoneinput)&DateFrom=\(datefrom.text ?? "")&DateTo=\(dateto.text ?? "")&Token=\(postStringencoding ?? "")";
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
                                             
                                            
                                           let res = try JSONDecoder().decode(BalanceInformation.self, from: data)
                                             
                                           self.BalanceList = res.datarecords
                                           print("\(res.datarecords)")
                                            DispatchQueue.main.async() {
                                         //   self.tableview.reloadData()
                                               self.transaction_table.reloadData()
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
                          let alert = UIAlertController(title: "Error", message: "Internet Connection Failed" , preferredStyle : .alert)
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
struct BalanceInformation: Codable {
    var datarecords: [balancerecords]
   
    init(datarecords: [balancerecords]){
        self.datarecords = datarecords
    }
}
struct balancerecords :Codable {
    let la_id : Int?
    let la_type : String?
    let la_ref : String?
    let la_createdt : String?
    let la_createby : String?
    let la_amount : Double?
    let la_merchantid : String?
    let la_memberid : String?
    let la_points : Int?
    let la_ref2 : String?
    let la_revid : Int?
    
    
    
}
