//
//  BBallTriviaSingleton.swift
//  BasketballTrivia
//
//  Created by IOS on 18/02/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class BBallTriviaSingleton: NSObject
{
    static let shared = BBallTriviaSingleton()
    private override init() {
        
    }
    
    //SignUp
    var userId = ""
    var userName = ""
    var profilePic = ""
    var profileImage = UIImage()
    
    
    var QuestionArray = [[String:String]]()
    var level = 1
    
    func showAlert(title: String, message: String, twoBtn: Bool, btn1: String, btn2: String, VC: UIViewController)
    {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let ok_action = UIAlertAction.init(title: "OK", style: .default)
        let cancel_action = UIAlertAction.init(title: "Cancel", style: .default)
        alert.addAction(ok_action)
        
        if twoBtn
        {
            alert.addAction(cancel_action)
        }
        
        VC.present(alert, animated: true, completion: nil)
    }
    
    func showLoader()
    {
        DispatchQueue.main.async {
             SVProgressHUD.setDefaultMaskType(.custom)
                       
                       SVProgressHUD.setBackgroundColor(UIColor.clear)
                       
                      SVProgressHUD.setForegroundColor(UIColor(red: 9/255.0, green: 168/255.0, blue: 170/255.0, alpha: 1))
                       
                       SVProgressHUD.setRingThickness(10)
                       SVProgressHUD.setDefaultMaskType(.gradient)
                       SVProgressHUD.setRingRadius(150)
                       SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0, vertical: 0))
                                           
                       SVProgressHUD.show()
            
        }
        
        
    }
    
    func hideLoader()
    {
        SVProgressHUD.dismiss()
    }
    
}



