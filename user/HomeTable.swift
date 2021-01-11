//
//  HomeTable.swift
//  user
//
//  Created by Kek on 13/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HomeTable: UITableViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    @IBAction func balanceintent(_ sender: UIButton)
    {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "balance") as! UIViewController
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController,animated:true,completion:nil)
        
    }
    @IBAction func jompayintent(_ sender: UIButton)
    {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "jompay") as! UIViewController
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController,animated:true,completion:nil)
    }
    
    
    @IBAction func voucher(_ sender: UIButton)
    {
         DispatchQueue.main.async
        {
            let alert = UIAlertController(title: "", message: "Under Progress" , preferredStyle : .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
            switch action.style{
                                                                                  
            case .default : break
                                                                                     
            case .cancel : break
                                                                                     
            case .destructive : break
                                                                                 
            }}))
            self.present(alert,animated: true, completion: nil)
        }
    }
    
    
    @IBAction func rewards(_ sender: UIButton)
    {
         DispatchQueue.main.async
        {
        let alert = UIAlertController(title: "", message: "Under Progress" , preferredStyle : .alert)
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
    
    @IBAction func recommend(_ sender: UIButton)
    {
        DispatchQueue.main.async
        {
                let alert = UIAlertController(title: "", message: "Under Progress" , preferredStyle : .alert)
                   alert.addAction(UIAlertAction(title:"OK", style: .default ,handler:{action in
                   switch action.style{
                                                                           
                   case .default : break
                                                                              
                   case .cancel : break
                                                                              
                   case .destructive : break
                                                                          
                   }}))
                   self.present(alert,animated: true, completion: nil)
        }
    }
    
    @IBAction func findmerchantintent(_ sender: UIButton)
    {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "findmerchant") as! UIViewController
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController,animated:true,completion:nil)
        
    }
    @IBAction func payintent(_ sender: UIButton)
    {
         let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "scanpayqrcode") as! UIViewController
         nextViewController.modalPresentationStyle = .fullScreen
         present(nextViewController,animated:true,completion:nil)
        
    }
    
    
    @IBAction func topupintent(_ sender: UIButton)
    {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "scantopupqrcode") as! UIViewController
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController,animated:true,completion:nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        var cellHeight:CGFloat = CGFloat()
        cellHeight = UIScreen.main.bounds.height
        return cellHeight
    }
      
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              // #warning Incomplete implementation, return the number of rows
              return 1
          }

          
          override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
          {
              let cell = tableView.dequeueReusableCell(withIdentifier: "homecell", for: indexPath) as! HomeCell
              cell.selectionStyle = .none
              return cell
          }
         
}




  extension HomeTable: IndicatorInfoProvider{
         func indicatorInfo(for pagerTabStripController : PagerTabStripViewController) -> IndicatorInfo{
                
                 return IndicatorInfo(image: UIImage(named : "home"))
             }
         
         }


