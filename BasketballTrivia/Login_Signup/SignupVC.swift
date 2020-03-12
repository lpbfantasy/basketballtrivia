//
//  SignupVC.swift
//  BasketballTrivia
//
//  Created by IOS on 18/02/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class SignupVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtPassword || textField == txtConfirmPassword
        {
            textField.isSecureTextEntry = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @IBAction func signup_action(_ sender: Any) {
        
        if !(txtName.text!.isEmpty)
        {
            if txtPassword.text == txtConfirmPassword.text
            {
                 BBallTriviaSingleton.shared.showLoader()
                Auth.auth().createUser(withEmail: txtEmail.text ?? "", password: txtPassword.text ?? "") { authResult, error in
                    guard let user = authResult?.user, error == nil else{
                        BBallTriviaSingleton.shared.showAlert(title: "Error", message: error?.localizedDescription ?? "", twoBtn: false, btn1: "", btn2: "", VC: self)
                        return
                    }
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = self.txtName.text!
                    changeRequest?.commitChanges { (error) in
                        // ...
                    }
                    self.txtName.text = ""
                    self.txtEmail.text = ""
                    self.txtPassword.text = ""
                    self.txtConfirmPassword.text = ""
                    BBallTriviaSingleton.shared.hideLoader()
                    BBallTriviaSingleton.shared.showAlert(title: "Success", message: "SignUp successfull!!", twoBtn: false, btn1: "", btn2: "", VC: self)
                }
                
            }
            else
            {
                
                BBallTriviaSingleton.shared.showAlert(title: "Alert", message: "The two passwords entered do not match!! Please try again.", twoBtn: false, btn1: "", btn2: "", VC: self)
            }
            
            
        }
        else
        {
            //BBallTriviaSingleton.shared.showLoader()
            BBallTriviaSingleton.shared.showAlert(title: "Alert", message: "Please enter your name!!", twoBtn: false, btn1: "", btn2: "", VC: self)
        }
        
        
    }
    
    @IBAction func login_action(_ sender: Any) {
        
        if #available(iOS 13.0, *) {
            let vc = storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
        
    }
    
    @IBAction func back_action(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
