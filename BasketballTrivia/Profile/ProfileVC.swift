//
//  ProfileVC.swift
//  BasketballTrivia
//
//  Created by IOS on 27/02/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit
import ExpandableCell
import Firebase
import SDWebImage

class ProfileVC: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tblProfile: UITableView!
    
    var ExpandaableRowsOfSection1 = 1
    var ExpandaableRowsOfSection2 = 1
    var ExpandaableRowsOfSection3 = 1
     var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblProfile.delegate = self
        tblProfile.dataSource = self
        
        tblProfile.register(UINib.init(nibName: "ProfileTopCell", bundle: nil), forCellReuseIdentifier: "ProfileTopCellReuse")
        tblProfile.register(UINib.init(nibName: "ProfileExpandableCell", bundle: nil), forCellReuseIdentifier: "ProfileExpandableCellReuse")
        tblProfile.register(UINib.init(nibName: "ProfileBottomCell", bundle: nil), forCellReuseIdentifier: "ProfileBottomCellReuse")
        tblProfile.register(UINib.init(nibName: "ProfileExpansionCell", bundle: nil), forCellReuseIdentifier: "ProfileExpansionCellReuse")
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
          handle = Auth.auth().addStateDidChangeListener { (auth, user) in
              // ...
          }
      }
      
      override func viewWillDisappear(_ animated: Bool) {
          Auth.auth().removeStateDidChangeListener(handle!)
      }
    
    @objc func changeProfilePicture(_ sender: UIButton)
    {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = URL.init(string: "https://i.picsum.photos/id/555/200/300.jpg")
        changeRequest?.commitChanges { (error) in
            
            if error == nil
            {
             UserDefaults.standard.set("\(String(describing: Auth.auth().currentUser!.photoURL!))", forKey: "ProfilePicture")
            self.tblProfile.reloadSections([0], with: .automatic)
            }
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 
        {
            return 200
        }
        else if indexPath.section == 4
        {
            return 200
            
        }
        else
        {
            return 64
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 4
        {
            return 1
        }
        else if section == 1
        {
            return ExpandaableRowsOfSection1
        }
        else if section == 2
        {
            return ExpandaableRowsOfSection2
        }
        else if section == 3
        {
            return ExpandaableRowsOfSection3
        }
        else
        {
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell = tblProfile.dequeueReusableCell(withIdentifier: "ProfileTopCellReuse", for: indexPath) as! ProfileTopCell
            cell.btnAddProfile.addTarget(self, action: #selector(changeProfilePicture(_:)), for: .touchUpInside)
            cell.imgProfile.image = UIImage.init(named: "profileAdd")
        
            if UserDefaults.standard.value(forKey: "ProfilePicture") != nil
            {
                cell.imgProfile.sd_setImage(with:  URL(string: "\(String(describing: UserDefaults.standard.value(forKey: "ProfilePicture")!))"), completed: nil)
            }

            cell.cellDict = NSMutableDictionary()
            return cell
        }
        else if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                let cell = tblProfile.dequeueReusableCell(withIdentifier: "ProfileExpandableCellReuse", for: indexPath) as! ProfileExpandableCell
                cell.lblHeading.text = "Username"
                if ExpandaableRowsOfSection1 > 1
                {
                    cell.btnAdd.setImage(UIImage.init(named: "minus"), for: .normal)
                }
                else
                {
                    cell.btnAdd.setImage(UIImage.init(named: "addIcon"), for: .normal)
                }
                cell.btnAdd.tag = indexPath.section
                cell.btnAdd.addTarget(self, action: #selector(expandRows(_:)), for: .touchUpInside)
                return cell
            }
            else
            {
                let cell = tblProfile.dequeueReusableCell(withIdentifier: "ProfileExpansionCellReuse", for: indexPath) as! ProfileExpansionCell
                cell.mainView.layer.borderWidth = 1
                cell.mainView.layer.borderColor = UIColor.black.cgColor
                return cell
            }
        }
        else if indexPath.section == 2
        {
            if indexPath.row == 0
            {
                let cell = tblProfile.dequeueReusableCell(withIdentifier: "ProfileExpandableCellReuse", for: indexPath) as! ProfileExpandableCell
                cell.lblHeading.text = "Payment Options"
                if ExpandaableRowsOfSection2 > 1
                {
                    cell.btnAdd.setImage(UIImage.init(named: "minus"), for: .normal)
                }
                else
                {
                    cell.btnAdd.setImage(UIImage.init(named: "addIcon"), for: .normal)
                }
                cell.btnAdd.tag = indexPath.section
                cell.btnAdd.addTarget(self, action: #selector(expandRows(_:)), for: .touchUpInside)
                return cell
            }
                
            else
            {
                let cell = tblProfile.dequeueReusableCell(withIdentifier: "ProfileExpansionCellReuse", for: indexPath) as! ProfileExpansionCell
                
                cell.mainView.layer.borderWidth = 1
                cell.mainView.layer.borderColor = UIColor.black.cgColor
                return cell
            }
        }
        else if indexPath.section == 3
        {
            
            if indexPath.row == 0
            {
                let cell = tblProfile.dequeueReusableCell(withIdentifier: "ProfileExpandableCellReuse", for: indexPath) as! ProfileExpandableCell
                cell.lblHeading.text = "Notifications"
                if ExpandaableRowsOfSection3 > 1
                {
                    cell.btnAdd.setImage(UIImage.init(named: "minus"), for: .normal)
                }
                else
                {
                    cell.btnAdd.setImage(UIImage.init(named: "addIcon"), for: .normal)
                }
                cell.btnAdd.tag = indexPath.section
                cell.btnAdd.addTarget(self, action: #selector(expandRows(_:)), for: .touchUpInside)
                return cell
            }
            else
            {
                let cell = tblProfile.dequeueReusableCell(withIdentifier: "ProfileExpansionCellReuse", for: indexPath) as! ProfileExpansionCell
                cell.mainView.layer.borderWidth = 1
                cell.mainView.layer.borderColor = UIColor.black.cgColor
                return cell
            }
        }
        else
        {
            let cell = tblProfile.dequeueReusableCell(withIdentifier: "ProfileBottomCellReuse", for: indexPath) as! ProfileBottomCell
            cell.mainView.layer.cornerRadius = 12
            cell.mainView.clipsToBounds = true
            return cell
        }
    }
    
    
    @objc func expandRows(_ sender: UIButton)
    {
        
        if sender.tag == 1
        {
            if ExpandaableRowsOfSection1 == 1
            {
                ExpandaableRowsOfSection1 = 2
            }
            else
            {
                ExpandaableRowsOfSection1 = 1
            }
            
        }
        else if sender.tag == 2
        {
            if ExpandaableRowsOfSection2 == 1
            {
                ExpandaableRowsOfSection2 = 2
            }
            else
            {
                ExpandaableRowsOfSection2 = 1
            }
        }
        else if sender.tag == 3
        {
            if ExpandaableRowsOfSection3 == 1
            {
                ExpandaableRowsOfSection3 = 2
            }
            else
            {
                ExpandaableRowsOfSection3 = 1
            }
        }
        tblProfile.reloadSections([sender.tag], with: .automatic)
    }
    
    func setProfilePicture()
    {
        
    }
    
    
    @IBAction func back_action(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
}
