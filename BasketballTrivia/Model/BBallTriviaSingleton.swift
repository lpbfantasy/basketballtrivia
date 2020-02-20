//
//  BBallTriviaSingleton.swift
//  BasketballTrivia
//
//  Created by IOS on 18/02/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation
import UIKit

class BBallTriviaSingleton: NSObject
{
    static let shared = BBallTriviaSingleton()
    private override init() {
        
    }
    
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
    
}



