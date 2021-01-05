//
//  FindMerchant.swift
//  user
//
//  Created by Kek on 27/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit
import DropDown
import SDWebImage
class FindMerchant: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var findmerchantselection: UIButton!
    
    
    let dropDown = DropDown()
    
    
    let animals: [String] = ["MyScanPay", "24 HRS challenge", "One more day to go", "Free Top Up", "Notification"]
    
      let animals2: [String] = ["4/8/18: Today is the day??", "Want to know what goodies", "It's tomorrow??!! Try new items on", "Visit District 9 Cafe Bar @", "For enquiries, please"]
    

    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    var MerchantList = [merchantrecords]()
    var foodandbeverageList = [merchantrecords]()
    var healthcareList = [merchantrecords]()
    var haircaresaloonList = [merchantrecords]()
    var retailList = [merchantrecords]()
     var mobiletruckList = [merchantrecords]()
    var serviceList = [merchantrecords]()
    var othersList = [merchantrecords]()
    let picdomain = "https://www.myscanpay.com/"
    var urlString = ""
    var selectionint = 0
    var calculatecount = 0
    var exampleretail = 0
    var examplemobiletruck = 0
    var examplefood = 0
    var examplehealthcare = 0
    var exampleservice = 0
    var examplehaircaresaloon = 0
    var exampleothers = 0
    var indicator = false
    
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
       
        if self.selectionint == 0
        {
            self.calculatecount = self.examplefood
        }
        if self.selectionint == 1
        {
            self.calculatecount = self.examplehealthcare
        }
        if self.selectionint == 2
        {
            self.calculatecount = self.examplehaircaresaloon
        }
        if self.selectionint == 3
        {
            self.calculatecount = self.exampleservice
        }
        if self.selectionint == 4
        {
            self.calculatecount = self.exampleretail
        }
        if self.selectionint == 5
        {
            self.calculatecount = self.examplemobiletruck
        }
        if self.selectionint == 6
        {
            self.calculatecount = self.exampleothers
        }
        
        
        return self.calculatecount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:FindMerchantTableViewCell = self.tableview.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! FindMerchantTableViewCell
               // set the text from the data model
       // print(indexPath.row)
        cell.layer.borderColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1).cgColor
        cell.layer.borderWidth = 3.0
        if self.selectionint == 0
        {
           
            cell.celltitle?.text = self.foodandbeverageList[indexPath.row].m_companyname;
                
                let profileimagepath = self.foodandbeverageList[indexPath.row].m_profileimagepath
                let profilefilename = self.foodandbeverageList[indexPath.row].m_profilefilename
                
                if profileimagepath != nil && profilefilename != nil
                {
                    urlString = self.picdomain + (profileimagepath ?? "") + (profilefilename ?? "")
                }
                
                
                cell.cellimage?.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "messagecenter"))
                       //cell.cellimage?.image = UIImage (named: "messagecenter")
                
                
                
                cell.celldetail?.text = self.foodandbeverageList[indexPath.row].m_address1
                 cell.celldetail2?.text = self.foodandbeverageList[indexPath.row].m_address2
                 cell.celldetail3?.text = self.foodandbeverageList[indexPath.row].m_address3
            
            if self.foodandbeverageList[indexPath.row].m_topup == true
            {
                cell.celltopup?.isHidden = false
            }
            else
            {
                cell.celltopup?.isHidden = true
                
            }
               
            
        }
        else if self.selectionint == 1
        {
            cell.celltitle?.text = self.healthcareList[indexPath.row].m_companyname;
                           
                           let profileimagepath = self.healthcareList[indexPath.row].m_profileimagepath
                           let profilefilename = self.healthcareList[indexPath.row].m_profilefilename
                           
                           if profileimagepath != nil && profilefilename != nil
                           {
                               urlString = self.picdomain + (profileimagepath ?? "") + (profilefilename ?? "")
                           }
                           
                           
                           cell.cellimage?.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "messagecenter"))
                                  //cell.cellimage?.image = UIImage (named: "messagecenter")
                           
                           
                           
                           cell.celldetail?.text = self.healthcareList[indexPath.row].m_address1
                            cell.celldetail2?.text = self.healthcareList[indexPath.row].m_address2
                            cell.celldetail3?.text = self.healthcareList[indexPath.row].m_address3
            
            if self.healthcareList[indexPath.row].m_topup == true
                       {
                           cell.celltopup?.isHidden = false
                       }
                       else
                       {
                           cell.celltopup?.isHidden = true
                           
                       }
        }
       else if self.selectionint == 2
        {
            cell.celltitle?.text = self.haircaresaloonList[indexPath.row].m_companyname;
                           
                           let profileimagepath = self.haircaresaloonList[indexPath.row].m_profileimagepath
                           let profilefilename = self.haircaresaloonList[indexPath.row].m_profilefilename
                           
                           if profileimagepath != nil && profilefilename != nil
                           {
                               urlString = self.picdomain + (profileimagepath ?? "") + (profilefilename ?? "")
                           }
                           
                           
                           cell.cellimage?.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "messagecenter"))
                                  //cell.cellimage?.image = UIImage (named: "messagecenter")
                           
                           
                           
                           cell.celldetail?.text = self.haircaresaloonList[indexPath.row].m_address1
                            cell.celldetail2?.text = self.haircaresaloonList[indexPath.row].m_address2
                            cell.celldetail3?.text = self.haircaresaloonList[indexPath.row].m_address3
            if self.haircaresaloonList[indexPath.row].m_topup == true
                       {
                           cell.celltopup?.isHidden = false
                       }
                       else
                       {
                           cell.celltopup?.isHidden = true
                           
                       }
        }
      else  if self.selectionint == 3
                   {
                      
                    cell.celltitle?.text = self.serviceList[indexPath.row].m_companyname;
                           
                           let profileimagepath = self.serviceList[indexPath.row].m_profileimagepath
                           let profilefilename = self.serviceList[indexPath.row].m_profilefilename
                           
                           if profileimagepath != nil && profilefilename != nil
                           {
                               urlString = self.picdomain + (profileimagepath ?? "") + (profilefilename ?? "")
                           }
                           
                           
                           cell.cellimage?.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "messagecenter"))
                                  //cell.cellimage?.image = UIImage (named: "messagecenter")
                           
                           
                           
                           cell.celldetail?.text = self.serviceList[indexPath.row].m_address1
                            cell.celldetail2?.text = self.serviceList[indexPath.row].m_address2
                            cell.celldetail3?.text = self.serviceList[indexPath.row].m_address3
                          if self.serviceList[indexPath.row].m_topup == true
                                               {
                                                   cell.celltopup?.isHidden = false
                                               }
                                               else
                                               {
                                                   cell.celltopup?.isHidden = true
                                                   
                                               }
                    
        }
        
        else if self.selectionint == 4
        {
            
            cell.celltitle?.text = self.retailList[indexPath.row].m_companyname
            
          let profileimagepath = self.retailList[indexPath.row].m_profileimagepath
          let profilefilename = self.retailList[indexPath.row].m_profilefilename
          
          if profileimagepath != nil && profilefilename != nil
          {
              urlString = self.picdomain + (profileimagepath ?? "") + (profilefilename ?? "")
          }
          
          
          cell.cellimage?.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "messagecenter"))
                 //cell.cellimage?.image = UIImage (named: "messagecenter")
          
          
          
          cell.celldetail?.text = self.retailList[indexPath.row].m_address1
           cell.celldetail2?.text = self.retailList[indexPath.row].m_address2
           cell.celldetail3?.text = self.retailList[indexPath.row].m_address3
            if self.retailList[indexPath.row].m_topup == true
                                 {
                                     cell.celltopup?.isHidden = false
                                 }
                                 else
                                 {
                                     cell.celltopup?.isHidden = true
                                     
                                 }
        
        }
        else if self.selectionint == 5
        {
            
            cell.celltitle?.text = self.mobiletruckList[indexPath.row].m_companyname
            
          let profileimagepath = self.mobiletruckList[indexPath.row].m_profileimagepath
          let profilefilename = self.mobiletruckList[indexPath.row].m_profilefilename
          
          if profileimagepath != nil && profilefilename != nil
          {
              urlString = self.picdomain + (profileimagepath ?? "") + (profilefilename ?? "")
          }
          
          
          cell.cellimage?.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "messagecenter"))
                 //cell.cellimage?.image = UIImage (named: "messagecenter")
          
          
          
          cell.celldetail?.text = self.mobiletruckList[indexPath.row].m_address1
           cell.celldetail2?.text = self.mobiletruckList[indexPath.row].m_address2
           cell.celldetail3?.text = self.mobiletruckList[indexPath.row].m_address3
            if self.mobiletruckList[indexPath.row].m_topup == true
                                 {
                                     cell.celltopup?.isHidden = false
                                 }
                                 else
                                 {
                                     cell.celltopup?.isHidden = true
                                     
                                 }
        
        }
        else if self.selectionint == 6
              {
                  
                  cell.celltitle?.text = self.othersList[indexPath.row].m_companyname
                  
                let profileimagepath = self.othersList[indexPath.row].m_profileimagepath
                let profilefilename = self.othersList[indexPath.row].m_profilefilename
                
                if profileimagepath != nil && profilefilename != nil
                {
                    urlString = self.picdomain + (profileimagepath ?? "") + (profilefilename ?? "")
                }
                
                
                cell.cellimage?.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "messagecenter"))
                       //cell.cellimage?.image = UIImage (named: "messagecenter")
                
                
                
                cell.celldetail?.text = self.othersList[indexPath.row].m_address1
                 cell.celldetail2?.text = self.othersList[indexPath.row].m_address2
                 cell.celldetail3?.text = self.othersList[indexPath.row].m_address3
                if self.othersList[indexPath.row].m_topup == true
                                     {
                                         cell.celltopup?.isHidden = false
                                     }
                                     else
                                     {
                                         cell.celltopup?.isHidden = true
                                         
                                     }
              
              }


               return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
               var cellHeight:CGFloat = CGFloat()

              
                   cellHeight = 120
             
               return cellHeight
           }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
         if self.selectionint == 0
         {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "findmerchantdetail") as! FindMerchantDetail
            nextViewController.findmerchant_companyname = self.foodandbeverageList[indexPath.row].m_companyname!;
            nextViewController.findmerchant_profileimagepath = self.foodandbeverageList[indexPath.row].m_profileimagepath!
            nextViewController.findmerchant_profilefilename = (self.foodandbeverageList[indexPath.row].m_profilefilename ?? "")
            nextViewController.findmerchant_photofilename1 = (self.foodandbeverageList[indexPath.row].m_photofilename1 ?? "")
            nextViewController.findmerchant_photofilename2 = (self.foodandbeverageList[indexPath.row].m_photofilename2 ?? "")
            nextViewController.findmerchant_photofilename3 = (self.foodandbeverageList[indexPath.row].m_photofilename3 ?? "")
    
            nextViewController.findmerchant_address1 = self.foodandbeverageList[indexPath.row].m_address1!
            nextViewController.findmerchant_address2 = self.foodandbeverageList[indexPath.row].m_address2!
            nextViewController.findmerchant_address3 = self.foodandbeverageList[indexPath.row].m_address3!
            nextViewController.findmerchant_address4 = self.foodandbeverageList[indexPath.row].m_address4!
            nextViewController.findmerchant_telcc =
                self.foodandbeverageList[indexPath.row].m_telcc!
            nextViewController.findmerchant_telac =
                self.foodandbeverageList[indexPath.row].m_telac!
            nextViewController.findmerchant_telno =
                self.foodandbeverageList[indexPath.row].m_telno!
             nextViewController.findmerchant_mobileno =
                self.foodandbeverageList[indexPath.row].m_mobileno!
            nextViewController.findmerchant_email =
                self.foodandbeverageList[indexPath.row].m_email!
            nextViewController.findmerchant_country =
                self.foodandbeverageList[indexPath.row].m_country!
            nextViewController.findmerchant_state =
                self.foodandbeverageList[indexPath.row].m_state!
            nextViewController.findmerchant_city =
                self.foodandbeverageList[indexPath.row].m_city!
            nextViewController.findmerchant_url =
                self.foodandbeverageList[indexPath.row].m_url!
            nextViewController.findmerchant_longtitude =
                self.foodandbeverageList[indexPath.row].m_longtitude!
            nextViewController.findmerchant_latitude =
                self.foodandbeverageList[indexPath.row].m_latitude!
            nextViewController.findmerchant_businesshour =
                self.foodandbeverageList[indexPath.row].m_businesshour!
            nextViewController.findmerchant_remarks =
                self.foodandbeverageList[indexPath.row].m_remarks!
            nextViewController.modalPresentationStyle = .fullScreen
            present(nextViewController,animated:true,completion:nil)
         }
        else if self.selectionint == 1
                {
                   let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "findmerchantdetail") as! FindMerchantDetail
                   nextViewController.findmerchant_companyname = self.healthcareList[indexPath.row].m_companyname!;
                   nextViewController.findmerchant_profileimagepath = self.healthcareList[indexPath.row].m_profileimagepath!
                   nextViewController.findmerchant_profilefilename = (self.healthcareList[indexPath.row].m_profilefilename ?? "")
                   nextViewController.findmerchant_photofilename1 =
                    (self.healthcareList[indexPath.row].m_photofilename1 ?? "")
                   nextViewController.findmerchant_photofilename2 =  (self.healthcareList[indexPath.row].m_photofilename2 ?? "")
                   nextViewController.findmerchant_photofilename3 =  (self.healthcareList[indexPath.row].m_photofilename3 ?? "")
           
                   nextViewController.findmerchant_address1 = self.healthcareList[indexPath.row].m_address1!
                   nextViewController.findmerchant_address2 = self.healthcareList[indexPath.row].m_address2!
                   nextViewController.findmerchant_address3 = self.healthcareList[indexPath.row].m_address3!
                   nextViewController.findmerchant_address4 = self.healthcareList[indexPath.row].m_address4!
                   nextViewController.findmerchant_telcc =
                       self.healthcareList[indexPath.row].m_telcc!
                   nextViewController.findmerchant_telac =
                       self.healthcareList[indexPath.row].m_telac!
                   nextViewController.findmerchant_telno =
                       self.healthcareList[indexPath.row].m_telno!
                    nextViewController.findmerchant_mobileno =
                       self.healthcareList[indexPath.row].m_mobileno!
                   nextViewController.findmerchant_email =
                       self.healthcareList[indexPath.row].m_email!
                   nextViewController.findmerchant_country =
                       self.healthcareList[indexPath.row].m_country!
                   nextViewController.findmerchant_state =
                       self.healthcareList[indexPath.row].m_state!
                   nextViewController.findmerchant_city =
                       self.healthcareList[indexPath.row].m_city!
                   nextViewController.findmerchant_url =
                       self.healthcareList[indexPath.row].m_url!
                   nextViewController.findmerchant_longtitude =
                       self.healthcareList[indexPath.row].m_longtitude!
                   nextViewController.findmerchant_latitude =
                       self.healthcareList[indexPath.row].m_latitude!
                   nextViewController.findmerchant_businesshour =
                       self.healthcareList[indexPath.row].m_businesshour!
                   nextViewController.findmerchant_remarks =
                       self.healthcareList[indexPath.row].m_remarks!
                   nextViewController.modalPresentationStyle = .fullScreen
                   present(nextViewController,animated:true,completion:nil)
                }
        else if self.selectionint == 2
             {
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "findmerchantdetail") as! FindMerchantDetail
                nextViewController.findmerchant_companyname = self.haircaresaloonList[indexPath.row].m_companyname!;
                nextViewController.findmerchant_profileimagepath = self.haircaresaloonList[indexPath.row].m_profileimagepath!
                nextViewController.findmerchant_profilefilename = (self.haircaresaloonList[indexPath.row].m_profilefilename ?? "")
                nextViewController.findmerchant_photofilename1 = (self.haircaresaloonList[indexPath.row].m_photofilename1 ?? "")
                nextViewController.findmerchant_photofilename2 = (self.haircaresaloonList[indexPath.row].m_photofilename2 ?? "")
                nextViewController.findmerchant_photofilename3 = (self.haircaresaloonList[indexPath.row].m_photofilename3 ?? "")
        
                nextViewController.findmerchant_address1 = self.haircaresaloonList[indexPath.row].m_address1!
                nextViewController.findmerchant_address2 = self.haircaresaloonList[indexPath.row].m_address2!
                nextViewController.findmerchant_address3 = self.haircaresaloonList[indexPath.row].m_address3!
                nextViewController.findmerchant_address4 = self.haircaresaloonList[indexPath.row].m_address4!
                nextViewController.findmerchant_telcc =
                    self.haircaresaloonList[indexPath.row].m_telcc!
                nextViewController.findmerchant_telac =
                    self.haircaresaloonList[indexPath.row].m_telac!
                nextViewController.findmerchant_telno =
                    self.haircaresaloonList[indexPath.row].m_telno!
                 nextViewController.findmerchant_mobileno =
                    self.haircaresaloonList[indexPath.row].m_mobileno!
                nextViewController.findmerchant_email =
                    self.haircaresaloonList[indexPath.row].m_email!
                nextViewController.findmerchant_country =
                    self.haircaresaloonList[indexPath.row].m_country!
                nextViewController.findmerchant_state =
                    self.haircaresaloonList[indexPath.row].m_state!
                nextViewController.findmerchant_city =
                    self.haircaresaloonList[indexPath.row].m_city!
                nextViewController.findmerchant_url =
                    self.haircaresaloonList[indexPath.row].m_url!
                nextViewController.findmerchant_longtitude =
                    self.haircaresaloonList[indexPath.row].m_longtitude!
                nextViewController.findmerchant_latitude =
                    self.haircaresaloonList[indexPath.row].m_latitude!
                nextViewController.findmerchant_businesshour =
                    self.haircaresaloonList[indexPath.row].m_businesshour!
                nextViewController.findmerchant_remarks =
                    self.haircaresaloonList[indexPath.row].m_remarks!
                nextViewController.modalPresentationStyle = .fullScreen
                present(nextViewController,animated:true,completion:nil)
             }
        else if self.selectionint == 3
                       {
                          let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "findmerchantdetail") as! FindMerchantDetail
                          nextViewController.findmerchant_companyname = self.serviceList[indexPath.row].m_companyname!;
                          nextViewController.findmerchant_profileimagepath = self.serviceList[indexPath.row].m_profileimagepath!
                          nextViewController.findmerchant_profilefilename = (self.serviceList[indexPath.row].m_profilefilename ?? "")
                          nextViewController.findmerchant_photofilename1 = (self.serviceList[indexPath.row].m_photofilename1 ?? "")
                          nextViewController.findmerchant_photofilename2 = (self.serviceList[indexPath.row].m_photofilename2 ?? "")
                          nextViewController.findmerchant_photofilename3 = (self.serviceList[indexPath.row].m_photofilename3 ?? "")
                  
                          nextViewController.findmerchant_address1 = self.serviceList[indexPath.row].m_address1!
                          nextViewController.findmerchant_address2 = self.serviceList[indexPath.row].m_address2!
                          nextViewController.findmerchant_address3 = self.serviceList[indexPath.row].m_address3!
                          nextViewController.findmerchant_address4 = self.serviceList[indexPath.row].m_address4!
                          nextViewController.findmerchant_telcc =
                              self.serviceList[indexPath.row].m_telcc!
                          nextViewController.findmerchant_telac =
                              self.serviceList[indexPath.row].m_telac!
                          nextViewController.findmerchant_telno =
                              self.serviceList[indexPath.row].m_telno!
                           nextViewController.findmerchant_mobileno =
                              self.serviceList[indexPath.row].m_mobileno!
                          nextViewController.findmerchant_email =
                              self.serviceList[indexPath.row].m_email!
                          nextViewController.findmerchant_country =
                              self.serviceList[indexPath.row].m_country!
                          nextViewController.findmerchant_state =
                              self.serviceList[indexPath.row].m_state!
                          nextViewController.findmerchant_city =
                              self.serviceList[indexPath.row].m_city!
                          nextViewController.findmerchant_url =
                              self.serviceList[indexPath.row].m_url!
                          nextViewController.findmerchant_longtitude =
                              self.serviceList[indexPath.row].m_longtitude!
                          nextViewController.findmerchant_latitude =
                              self.serviceList[indexPath.row].m_latitude!
                          nextViewController.findmerchant_businesshour =
                              self.serviceList[indexPath.row].m_businesshour!
                          nextViewController.findmerchant_remarks =
                              self.serviceList[indexPath.row].m_remarks!
                          nextViewController.modalPresentationStyle = .fullScreen
                          present(nextViewController,animated:true,completion:nil)
                       }
        else if self.selectionint == 4
                              {
                                 let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "findmerchantdetail") as! FindMerchantDetail
                                 nextViewController.findmerchant_companyname = self.retailList[indexPath.row].m_companyname!;
                                 nextViewController.findmerchant_profileimagepath = self.retailList[indexPath.row].m_profileimagepath!
                                 nextViewController.findmerchant_profilefilename = (self.retailList[indexPath.row].m_profilefilename ?? "")
                                 nextViewController.findmerchant_photofilename1 = (self.retailList[indexPath.row].m_photofilename1 ?? "")
                                 nextViewController.findmerchant_photofilename2 = (self.retailList[indexPath.row].m_photofilename2 ?? "")
                                 nextViewController.findmerchant_photofilename3 = (self.retailList[indexPath.row].m_photofilename3 ?? "")
                         
                                 nextViewController.findmerchant_address1 = self.retailList[indexPath.row].m_address1!
                                 nextViewController.findmerchant_address2 = self.retailList[indexPath.row].m_address2!
                                 nextViewController.findmerchant_address3 = self.retailList[indexPath.row].m_address3!
                                 nextViewController.findmerchant_address4 = self.retailList[indexPath.row].m_address4!
                                 nextViewController.findmerchant_telcc =
                                     self.retailList[indexPath.row].m_telcc!
                                 nextViewController.findmerchant_telac =
                                     self.retailList[indexPath.row].m_telac!
                                 nextViewController.findmerchant_telno =
                                     self.retailList[indexPath.row].m_telno!
                                  nextViewController.findmerchant_mobileno =
                                     self.retailList[indexPath.row].m_mobileno!
                                 nextViewController.findmerchant_email =
                                     self.retailList[indexPath.row].m_email!
                                 nextViewController.findmerchant_country =
                                     self.retailList[indexPath.row].m_country!
                                 nextViewController.findmerchant_state =
                                     self.retailList[indexPath.row].m_state!
                                 nextViewController.findmerchant_city =
                                     self.retailList[indexPath.row].m_city!
                                 nextViewController.findmerchant_url =
                                     self.retailList[indexPath.row].m_url!
                                 nextViewController.findmerchant_longtitude =
                                     self.retailList[indexPath.row].m_longtitude!
                                 nextViewController.findmerchant_latitude =
                                     self.retailList[indexPath.row].m_latitude!
                                 nextViewController.findmerchant_businesshour =
                                     self.retailList[indexPath.row].m_businesshour!
                                 nextViewController.findmerchant_remarks =
                                     self.retailList[indexPath.row].m_remarks!
                                 nextViewController.modalPresentationStyle = .fullScreen
                                 present(nextViewController,animated:true,completion:nil)
                              }
        
        else if self.selectionint == 5
                              {
                                 let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "findmerchantdetail") as! FindMerchantDetail
                                 nextViewController.findmerchant_companyname = self.mobiletruckList[indexPath.row].m_companyname!;
                                 nextViewController.findmerchant_profileimagepath = self.mobiletruckList[indexPath.row].m_profileimagepath!
                                 nextViewController.findmerchant_profilefilename = (self.mobiletruckList[indexPath.row].m_profilefilename ?? "")
                                 nextViewController.findmerchant_photofilename1 = (self.mobiletruckList[indexPath.row].m_photofilename1 ?? "")
                                 nextViewController.findmerchant_photofilename2 = (self.mobiletruckList[indexPath.row].m_photofilename2 ?? "")
                                 nextViewController.findmerchant_photofilename3 = (self.mobiletruckList[indexPath.row].m_photofilename3 ?? "")
                         
                                 nextViewController.findmerchant_address1 = self.mobiletruckList[indexPath.row].m_address1!
                                 nextViewController.findmerchant_address2 = self.mobiletruckList[indexPath.row].m_address2!
                                 nextViewController.findmerchant_address3 = self.mobiletruckList[indexPath.row].m_address3!
                                 nextViewController.findmerchant_address4 = self.mobiletruckList[indexPath.row].m_address4!
                                 nextViewController.findmerchant_telcc =
                                     self.mobiletruckList[indexPath.row].m_telcc!
                                 nextViewController.findmerchant_telac =
                                     self.mobiletruckList[indexPath.row].m_telac!
                                 nextViewController.findmerchant_telno =
                                     self.mobiletruckList[indexPath.row].m_telno!
                                  nextViewController.findmerchant_mobileno =
                                     self.mobiletruckList[indexPath.row].m_mobileno!
                                 nextViewController.findmerchant_email =
                                     self.mobiletruckList[indexPath.row].m_email!
                                 nextViewController.findmerchant_country =
                                     self.mobiletruckList[indexPath.row].m_country!
                                 nextViewController.findmerchant_state =
                                     self.mobiletruckList[indexPath.row].m_state!
                                 nextViewController.findmerchant_city =
                                     self.mobiletruckList[indexPath.row].m_city!
                                 nextViewController.findmerchant_url =
                                     self.mobiletruckList[indexPath.row].m_url!
                                 nextViewController.findmerchant_longtitude =
                                     self.mobiletruckList[indexPath.row].m_longtitude!
                                 nextViewController.findmerchant_latitude =
                                     self.mobiletruckList[indexPath.row].m_latitude!
                                 nextViewController.findmerchant_businesshour =
                                     self.mobiletruckList[indexPath.row].m_businesshour!
                                 nextViewController.findmerchant_remarks =
                                     self.mobiletruckList[indexPath.row].m_remarks!
                                 nextViewController.modalPresentationStyle = .fullScreen
                                 present(nextViewController,animated:true,completion:nil)
                              }
        else if self.selectionint == 6
                                   {
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
        
    }
   // func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
   // print("You tapped cell number \(indexPath.row).")
   //       }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
       
        tableview.delegate = self
        tableview.dataSource = self
         reloadalldatapage()
        // Do any additional setup after loading the view.
        
        findmerchantselection.backgroundColor = UIColor.white
        

               // The view to which the drop down will appear on
               dropDown.anchorView = findmerchantselection // UIView or UIBarButtonItem

               // The list of items to display. Can be changed dynamically
               dropDown.dataSource = ["Food And Beverage", "Health Care", "Hair Care And Saloon","Services","Retail","Mobile Truck", "Others"]
               
                dropDown.selectRow(at: 0)
                self.findmerchantselection.setTitle("Food And Beverage", for: .normal)
               dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
             
                self.findmerchantselection.setTitle(item, for: .normal)
                
                self.selectionint = index
               
                DispatchQueue.main.async()
                {
                self.tableview.reloadData()
                                                                                               
                }
               }
        
         NotificationCenter.default.addObserver(self, selector: #selector(TopChangeFrame), name: NSNotification.Name.UIWindowDidBecomeVisible, object: nil)
                    
        
    }
    

    
    @objc func TopChangeFrame(notification: NSNotification) {
                 if UIDevice.current.hasTopNotch {
                                  
                      self.view.frame.origin.y = 30
                               
                                }
                                  else{
                                        self.view.frame.origin.y = 0
                                  
                                  
                                  }
         
       }
    @IBAction func selection_click(_ sender: UIButton) {
        
         dropDown.show()
    }
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)    }
    
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
                                            if res.datarecords[n].m_businesstype == 1
                                            {
                                                self.examplefood = self.examplefood + 1
                                                self.foodandbeverageList.append(res.datarecords[n])
                                                
                                            }
                                            else if res.datarecords[n].m_businesstype == 2
                                            {
                                                self.examplehealthcare = self.examplehealthcare + 1
                                                self.healthcareList.append(res.datarecords[n])
                                            }
                                            else if res.datarecords[n].m_businesstype == 3
                                            {
                                                self.examplehaircaresaloon = self.examplehaircaresaloon + 1
                                                self.haircaresaloonList.append(res.datarecords[n])
                                            }
                                            
                                            else if res.datarecords[n].m_businesstype == 1004
                                            {
                                                self.exampleretail = self.exampleretail + 1
                                                self.retailList.append(res.datarecords[n])
                                            
                                              
                                                
                                            }
                                            else if res.datarecords[n].m_businesstype == 1002
                                            {
                                                self.exampleservice = self.exampleservice + 1
                                                self.serviceList.append(res.datarecords[n])
                                            }
                                            else if res.datarecords[n].m_businesstype == 1005
                                            {
                                                self.examplemobiletruck = self.examplemobiletruck + 1
                                                self.mobiletruckList.append(res.datarecords[n])
                                            }
                                           
                                            else if res.datarecords[n].m_businesstype == 1003
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
}

struct FindMerchantInformation: Codable {
    var datarecords: [merchantrecords]
   
    init(datarecords: [merchantrecords]){
        self.datarecords = datarecords
    }

}

struct merchantrecords :Codable {
    let m_id : Int?
    let m_companyname : String?
    let m_businesstype : Int?
    let m_address1 : String?
    let m_address2 : String?
    let m_address3 : String?
    let m_address4 : String?
    let m_telcc  : String?
    let m_telac : String?
    let m_telno : String?
    let m_mobileno : String?
    let m_email : String?
    let m_country : String?
    let m_state : String?
    let m_city  : String?
    let m_profilefilename : String?
    let m_photofilename1 : String?
    let m_photofilename2 : String?
    let m_photofilename3 : String?
    let m_profileimagepath : String?
    let m_url : String?
    let m_longtitude : String?
    let m_latitude : String?
    let m_businesshour : String?
    let m_remarks : String?
    let m_topup : Bool?
    
}
