//
//  ProfileTopCell.swift
//  BasketballTrivia
//
//  Created by IOS on 27/02/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class ProfileTopCell: UITableViewCell {

    
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnAddProfile: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var cellDict: NSMutableDictionary = [:]
    {
        didSet
        {
            self.imgProfile.layer.cornerRadius = 70
            self.imgProfile.clipsToBounds = true
        }
    }
    
}
