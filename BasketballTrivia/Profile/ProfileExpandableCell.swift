//
//  ProfileExpandableCell.swift
//  BasketballTrivia
//
//  Created by IOS on 27/02/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class ProfileExpandableCell: UITableViewCell {

    
    @IBOutlet weak var lblHeading: UILabel!
    
    @IBOutlet weak var btnAdd: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
