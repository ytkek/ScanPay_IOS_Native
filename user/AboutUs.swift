//
//  AboutUs.swift
//  user
//
//  Created by Kek on 24/03/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit

class AboutUs: UIViewController {
    
    
      override func viewWillAppear(_ animated: Bool)
      {
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

    override func viewDidLoad() {
        super.viewDidLoad()
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

}
