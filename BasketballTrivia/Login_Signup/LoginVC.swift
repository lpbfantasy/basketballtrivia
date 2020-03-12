//
//  LoginVC.swift
//  BasketballTrivia
//
//  Created by IOS on 18/02/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmailAddress.delegate = self
        txtPassword.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtPassword
        {
            textField.isSecureTextEntry = true
        }
    }
    
    @IBAction func login_action(_ sender: Any) {
        
         BBallTriviaSingleton.shared.showLoader()
        Auth.auth().signIn(withEmail: txtEmailAddress.text ?? "", password: txtPassword.text ?? "") { [weak self] authResult, error in
            if error != nil {
                BBallTriviaSingleton.shared.showAlert(title: "Error", message: error?.localizedDescription ?? "", twoBtn: false, btn1: "", btn2: "", VC: self!)
                BBallTriviaSingleton.shared.hideLoader()
            }
            else
            {
                BBallTriviaSingleton.shared.hideLoader()
                if #available(iOS 13.0, *) {
                    let vc = self?.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                
                UserDefaults.standard.set("\(String(describing: authResult!.user.uid))", forKey: "userId")
                UserDefaults.standard.set("\(String(describing: authResult!.user.displayName!))", forKey: "userName")
                if authResult?.user.photoURL != nil
                {
                    UserDefaults.standard.set("\(String(describing: authResult!.user.photoURL!))", forKey: "ProfilePicture")
                }
                else
                {
                    UserDefaults.standard.set("", forKey: "ProfilePicture")
                }
                
                
                
            }
            
            
        }
    }
    
    @IBAction func signup_action(_ sender: Any) {
        
        if #available(iOS 13.0, *) {
            let vc = storyboard?.instantiateViewController(identifier: "SignupVC") as! SignupVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}
