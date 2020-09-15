//
//  MainPageViewController.swift
//  user
//
//  Created by Kek on 13/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit
import Firebase

import XLPagerTabStrip

class MainPageViewController: ButtonBarPagerTabStripViewController {
    var oldcell: ButtonBarViewCell?
    var newcell: ButtonBarViewCell?
    
    var imageindicator = false;
     var imageindicator2 = false;
     var imageindicator3 = false;
    var jumpindicator = false;
     var jumpindicator2 = false;
     var jumpindicator3 = false;
    
    var limitindicator = false;
     var limitindicator2 = false;
     var limitindicator3 = false;
    var count = 0;
    override func viewDidLoad() {
               loadDesign()
        super.viewDidLoad()
        print("User"+UserPreference.retreiveLoginID())
        Messaging.messaging().subscribe(toTopic: UserPreference.retreiveLoginID() ?? "")
        // Do any additional setup after loading the view.
       
    }
    override func viewWillLayoutSubviews() {
       super.viewWillLayoutSubviews()

       DispatchQueue.main.async {
            self.moveToViewController(at: 1, animated: false)
             
            // needed or first tab stays highlighted
           // self.reloadPagerTabStripView()
       }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "discoverytable")
         let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "hometable")
         let child_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settingtable")
        
        return [child_1,child_2,child_3]
        
    }
    func loadDesign()
    {
         self.settings.style.selectedBarBackgroundColor = UIColor.red
       

        self.settings.style.buttonBarBackgroundColor = UIColor.init(red: 70/255, green: 138/255, blue: 201/255, alpha: 1.0)
        //self.settings.style.buttonBarItemBackgroundColor = UIColor.init(red: 70/255, green: 138/255, blue: 201/255, alpha: 1.0)
        if UIDevice.current.hasTopNotch {
            self.settings.style.buttonBarHeight = 130
        }
        else
        {
            self.settings.style.buttonBarHeight = 100
        }
        
        
        self.settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 8)
        self.settings.style.buttonBarItemLeftRightMargin = 10
        self.settings.style.selectedBarHeight = 5
        self.settings.style.buttonBarMinimumLineSpacing = 0
        
        self.settings.style.buttonBarItemsShouldFillAvailableWidth = true
        self.settings.style.buttonBarLeftContentInset = 0
        self.settings.style.buttonBarRightContentInset = 0
        
    
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?,newCell: ButtonBarViewCell?, progressPercentage: CGFloat,changeCurrentIndex: Bool,
            animated: Bool) -> Void in guard changeCurrentIndex == true else {return}
         
            
            oldCell?.label.textColor = UIColor.init(red: 70/255, green: 138/255, blue: 201/255, alpha: 1.0)
           // oldCell?.label.transform = CGAffineTransform(scaleX: 1.8, y:1.8)
            
            oldCell?.imageView.transform = CGAffineTransform(scaleX: 1.8, y:1.8)
            oldCell?.backgroundColor = UIColor.init(red: 70/255, green: 138/255, blue: 201/255, alpha: 1.0)

            newCell?.imageView.transform = CGAffineTransform(scaleX: 1.8, y:1.8)
           // newCell?.label.transform = CGAffineTransform(scaleX: 1.8, y:1.8)
           
            
            newCell?.label.textColor = UIColor.init(red: 70/255, green: 138/255, blue: 201/255, alpha: 1.0)
          //  newCell?.backgroundColor = UIColor.white
           
            self.oldcell=oldCell
            self.newcell = newCell
        }
        
    }
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
       super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        // if indexWasChanged && toIndex > -1 && toIndex < viewControllers.count {
          //  print("current",self.currentIndex)
     
        print("from",fromIndex)
        print("to",toIndex)
    
        //  if self.currentIndex == 0
        //          {
                      //self.oldcell?.imageView.image = UIImage(named:"discovery_blue")
                      // self.newcell?.label.frame.origin =  CGPoint(x: 0, y: -5)
                      
         //            self.newcell?.label.frame.origin =  CGPoint(x: 15, y: 60)
                      
                      
         //             self.newcell?.label.text = "DISCOVERY"
                     
                      
          //             self.view.layoutIfNeeded()
          //            limitindicator = true
          //             print("0")
           //       }
                 
           //       else if self.currentIndex == 1
          //        {
                      
                       //   self.newcell?.label.text = "HOME"
                       //   self.oldcell?.label.text = "HOME"
                      //    self.newcell?.label.frame.origin =  CGPoint(x: 15, y: 60)
                      //  self.oldcell?.label.frame.origin =  CGPoint(x: 15, y: 60)
                      
                      
                //                self.newcell?.label.frame.origin =  CGPoint(x: 30, y: 60)
                                 
                                 
                 //                self.newcell?.label.text = "HOME"
                                
                                 
                 //                 self.view.layoutIfNeeded()
                //      print("1")
              //    }
               //   else if self.currentIndex == 2
             //     {
                      //   self.newcell?.imageView.image = UIImage(named:"setting_blue")
                     // self.oldcell?.imageView.image = UIImage(named:"discovery");
                      // self.newcell?.label.text = "SETTING"
                     // self.oldcell?.label.text = "SETTING"
                     // self.newcell?.label.frame.origin =  CGPoint(x: 15, y: 60)
                      //  self.oldcell?.label.frame.origin =  CGPoint(x: 15, y: 60)
                //    self.newcell?.label.text = "SETTING";
                 //   self.newcell?.label.frame.origin =  CGPoint(x: 15, y: 60)
                                    
                                    
                                   
                                   
                                    
                 //                    self.view.layoutIfNeeded()
                //      print("2")
                //      limitindicator3 = true
                //  }
        
    //}
}
}
extension UIDevice{
    
    var hasTopNotch: Bool {
        
        if #available(iOS 11.0,tvOS 11.0, *)
        {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
}
