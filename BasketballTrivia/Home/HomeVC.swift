//
//  HomeVC.swift
//  BasketballTrivia
//
//  Created by IOS on 19/02/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HomeVC: UIViewController {

    
    @IBOutlet weak var adBannerView: GADBannerView!
    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewContainer.layer.cornerRadius = 20
        viewContainer.clipsToBounds = true
        
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
        imgProfile.clipsToBounds = true
        
        BBallTriviaSingleton.shared.showAlert(title: "Success", message: "User Id: \(UserDefaults.standard.value(forKey: "userId")!)\n UserName: \(UserDefaults.standard.value(forKey: "userName")!)", twoBtn: false, btn1: "", btn2: "", VC: self)
      
        adBannerView.adUnitID = "ca-app-pub-2483571791994176/5498549479"
        adBannerView.rootViewController = self
        adBannerView.load(GADRequest())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if  UserDefaults.standard.value(forKey: "ProfilePicture") != nil
        {
            if UserDefaults.standard.value(forKey: "ProfilePicture") != nil
            {
                self.imgProfile.sd_setImage(with:  URL(string: "\(String(describing: UserDefaults.standard.value(forKey: "ProfilePicture")!))"), completed: nil)
            }
            print(UserDefaults.standard.value(forKey: "ProfilePicture")!)
        }
                       
    }
   
    @IBAction func Profile_action(_ sender: Any) {
        if #available(iOS 13.0, *) {
                   let vc = storyboard?.instantiateViewController(identifier: "ProfileVC") as! ProfileVC
                   self.navigationController?.pushViewController(vc, animated: true)
               } else {
                  let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
                              self.navigationController?.pushViewController(vc, animated: true)
               }
    }
    

}
