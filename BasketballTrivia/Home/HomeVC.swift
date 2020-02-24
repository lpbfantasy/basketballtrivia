//
//  HomeVC.swift
//  BasketballTrivia
//
//  Created by IOS on 19/02/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    
    @IBOutlet weak var viewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewContainer.layer.cornerRadius = 20
        viewContainer.clipsToBounds = true
        
        BBallTriviaSingleton.shared.showAlert(title: "Success", message: "User Id: \(UserDefaults.standard.value(forKey: "userId")!)\n UserName: \(UserDefaults.standard.value(forKey: "userName")!)", twoBtn: false, btn1: "", btn2: "", VC: self)
    }
    

    

}
