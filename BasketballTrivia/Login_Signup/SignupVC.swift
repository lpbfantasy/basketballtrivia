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

class SignupVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    var handle: AuthStateDidChangeListenerHandle?
    let imagePicker = UIImagePickerController()
    
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
        
        if BBallTriviaSingleton.shared.profileImage != UIImage()
        {
            CloudinaryModelClass.shared.uploadImage(image: BBallTriviaSingleton.shared.profileImage) { (imgUrl, imgthumb) in
               
             BBallTriviaSingleton.shared.profilePic = imgUrl
                if !(self.txtName.text!.isEmpty)
                {
                    if self.txtPassword.text == self.txtConfirmPassword.text
                    {
                         BBallTriviaSingleton.shared.showLoader()
                        Auth.auth().createUser(withEmail: self.txtEmail.text ?? "", password: self.txtPassword.text ?? "") { authResult, error in
                            guard let user = authResult?.user, error == nil else{
                                BBallTriviaSingleton.shared.showAlert(title: "Error", message: error?.localizedDescription ?? "", twoBtn: false, btn1: "", btn2: "", VC: self)
                                return
                            }
                          do
                            {
                              BBallTriviaSingleton.shared.userId = user.uid
                          }
                            
                            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                            changeRequest?.displayName = self.txtName.text!
                            changeRequest?.commitChanges { (error) in
                                // ...
                            }
                           
                          self.callSignUpApi()
                                                  
                          
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
            
                  
        }
        else
        {
            BBallTriviaSingleton.shared.showAlert(title: "Alert", message: "Please select your Profile Image!!", twoBtn: false, btn1: "", btn2: "", VC: self)
        }
        
      
    }
    
    func callSignUpApi()
    {
        let dict = ["userId": BBallTriviaSingleton.shared.userId, "username" : self.txtName.text!, "profilepicture" : BBallTriviaSingleton.shared.profilePic]
        
        print(dict)
        apiManager.callApi.postApiRequest(controller: self, method: "http://kistchatstorage.com/BasketballTrivia/insertUser.php", parameters: dict, completionHandler: { (response, status) in
            
            
            if status
            {
              
                if "\(((response?.value(forKey: "data") as AnyObject).object(at: 0) as AnyObject).value(forKey: "status")!)"  == "1"
                {
                    self.txtName.text = ""
                    self.txtEmail.text = ""
                    self.txtPassword.text = ""
                    self.txtConfirmPassword.text = ""
                    BBallTriviaSingleton.shared.hideLoader()
                    BBallTriviaSingleton.shared.showAlert(title: "Success", message: "SignUp successfull!!", twoBtn: false, btn1: "", btn2: "", VC: self)
                }
                else
                {
                    let user = Auth.auth().currentUser

                    user?.delete { error in
                      if let _ = error {
                        // An error happened.
                      } else {
                         BBallTriviaSingleton.shared.showAlert(title: "Failure", message: "You could not sign up. Please try again!!", twoBtn: false, btn1: "", btn2: "", VC: self)
                      }
                    }
                   
                }
               
               
            }
        })
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
    
    
    @IBAction func selectImage_action(_ sender: Any) {
        
            imagePicker.delegate = self
              imagePicker.allowsEditing = true
              let alertController = UIAlertController(title: "Select Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
              
              let libAction = UIAlertAction(title: "Select from library", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.gallery()
                  
              })
              
              let captureAction = UIAlertAction(title: "Capture image", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.capture()
                  
              })
              
              let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
              
              alertController.addAction(libAction)
              alertController.addAction(captureAction)
              alertController.addAction(cancelAction)
              
              self.present(alertController, animated: true, completion:{})
    }
    
    // MARK: - UIImagePicker delegates
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           
           
           let chosenImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
           imgProfile.image = nil
           
           DispatchQueue.main.async {
               BBallTriviaSingleton.shared.profileImage = chosenImage
               self.imgProfile.image = chosenImage
               self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.width/2
               self.imgProfile.clipsToBounds = true
               self.imgProfile.contentMode = .scaleAspectFill
              
           }
           
           dismiss(animated: true, completion: {
               
           })
           
           
       }
       
       
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           dismiss(animated: true, completion: nil)
       }
       
       
       // MARK: - Functions
       
       func capture() {
           
           if UIImagePickerController.isSourceTypeAvailable(.camera)
           {
               imagePicker.sourceType = .camera
               present(imagePicker, animated: true, completion: nil)
           }
           else
           {
               
           }
       }
       
       func gallery(){
           imagePicker.allowsEditing = true
           imagePicker.sourceType = .photoLibrary
           present(imagePicker, animated: true, completion: nil)
       }
       
       func startUploadingProfileImage(Image:UIImage)
       {
           
           
       }
    
    
    @IBAction func back_action(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
