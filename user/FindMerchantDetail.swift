//
//  FindMerchantDetail.swift
//  user
//
//  Created by Kek on 14/04/2020.
//  Copyright © 2020 Kek. All rights reserved.
//

import UIKit
import SDWebImage
import MessageUI

class FindMerchantDetail: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var companyname_label: UILabel!
    
    @IBOutlet weak var profileimage: UIImageView!
    
    @IBOutlet weak var time_label: UILabel!
    
    @IBOutlet weak var remarks_label: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    
    var findmerchant_companyname = ""
    var findmerchant_domain = "https://www.myscanpay.com/"
    var findmerchant_profileimagepath = ""
    var findmerchant_profilefilename = ""
    var findmerchant_photofilename1 = ""
    var findmerchant_photofilename2 = ""
    var findmerchant_photofilename3 = ""
    
    var findmerchant_address1 = ""
    var findmerchant_address2 = ""
    var findmerchant_address3 = ""
    var findmerchant_address4 = ""
    var findmerchant_telcc = ""
    var findmerchant_telac = ""
    var findmerchant_telno = ""
    var findmerchant_mobileno = ""
    var findmerchant_email = ""
    var findmerchant_country = ""
    var findmerchant_state = ""
    var findmerchant_city = ""
    var findmerchant_url = ""
    var findmerchant_longtitude = ""
    var findmerchant_latitude = ""
    var findmerchant_businesshour = ""
    var findmerchant_remarks = ""
   
    var urlString = ""
     var urlString1 = ""
     var urlString2 = ""
     var urlString3 = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        companyname_label.text = findmerchant_companyname
         let transformerprofile = SDImageResizingTransformer(size: CGSize(width: 300, height: 250), scaleMode: .fill)
          urlString = findmerchant_domain + (findmerchant_profileimagepath ?? "") + (findmerchant_profilefilename ?? "")
          profileimage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "messagecenter"), context: [.imageTransformer: transformerprofile])
        
        let transformer = SDImageResizingTransformer(size: CGSize(width: 300, height: 300), scaleMode: .fill)
         urlString1 = findmerchant_domain + (findmerchant_profileimagepath ?? "") + (findmerchant_photofilename1 ?? "")
        image1.sd_setImage(with: URL(string: urlString1), placeholderImage: UIImage(named: "messagecenter"), context: [.imageTransformer: transformer])
        
        urlString2 = findmerchant_domain + (findmerchant_profileimagepath ?? "") + (findmerchant_photofilename2 ?? "")
              image2.sd_setImage(with: URL(string: urlString2), placeholderImage: UIImage(named: "messagecenter"),context: [.imageTransformer: transformer])
        
        urlString3 = findmerchant_domain + (findmerchant_profileimagepath ?? "") + (findmerchant_photofilename3 ?? "")
                     image3.sd_setImage(with: URL(string: urlString3), placeholderImage: UIImage(named: "messagecenter"),context: [.imageTransformer: transformer])
        
        time_label.text = findmerchant_businesshour
        remarks_label.text = findmerchant_remarks
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        profileimage.isUserInteractionEnabled = true
        profileimage.addGestureRecognizer(tapGestureRecognizer)
        image1.isUserInteractionEnabled = true
              image1.addGestureRecognizer(tapGestureRecognizer1)
        image2.isUserInteractionEnabled = true
              image2.addGestureRecognizer(tapGestureRecognizer2)
        image3.isUserInteractionEnabled = true
              image3.addGestureRecognizer(tapGestureRecognizer3)
        
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){

        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let newImageView = UIImageView(image: tappedImage.image)
           newImageView.frame = UIScreen.main.bounds
           newImageView.backgroundColor = .black
           newImageView.contentMode = .scaleAspectFit
           newImageView.isUserInteractionEnabled = true
           let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
           newImageView.addGestureRecognizer(tap)
           self.view.addSubview(newImageView)
           self.navigationController?.isNavigationBarHidden = true
           self.tabBarController?.tabBar.isHidden = true
        // Your action
    }
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    @IBAction func website(_ sender: UIButton) {
           UIApplication.shared.openURL(NSURL(string:findmerchant_url)! as URL)
             }
    

 

    
    @IBAction func email(_ sender: UIButton) {
         if MFMailComposeViewController.canSendMail() {
                   let mail = MFMailComposeViewController()
                   mail.mailComposeDelegate = self
                   mail.setToRecipients([findmerchant_email])
                   mail.setSubject("")
                   mail.setMessageBody("<p></p>", isHTML: true)
                   present(mail, animated: true)
               } else {
                   print("Application is not able to send an email")
               }
    }
     func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
           controller.dismiss(animated: true)
       }
    @IBAction func telephone(_ sender: UIButton) {
        
        callNumber(phoneNumber: findmerchant_telcc + findmerchant_telac + findmerchant_telno)
    }
    
    private func callNumber(phoneNumber:String) {

        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {

            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                     application.openURL(phoneCallURL as URL)

                }
            }
        }
    }
    @IBAction func map(_ sender: UIButton) {
        
    if(UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
        {
            UIApplication.shared.openURL(NSURL(string:
        "comgooglemaps://?saddr=&daddr=\(Float(findmerchant_latitude)!),\(Float(findmerchant_longtitude)!)&directionsmode=driving")! as URL)

        } else {
        
        UIApplication.shared.openURL(NSURL(string:
        "https://www.google.com/maps/?q=@\(Float(findmerchant_latitude)!),\(Float(findmerchant_longtitude)!)")! as URL)
        }
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion:nil)
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
