//
//  ProfileBottomCell.swift
//  BasketballTrivia
//
//  Created by IOS on 27/02/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class ProfileBottomCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblOverallPoints: UILabel!
    
    @IBOutlet weak var lblLevelPoints: UILabel!
    
    @IBOutlet weak var lblPoints: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
