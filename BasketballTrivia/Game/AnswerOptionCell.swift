//
//  AnswerOptionCell.swift
//  BasketballTrivia
//
//  Created by IOS on 05/03/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class AnswerOptionCell: UITableViewCell {

    @IBOutlet weak var lblAnswer: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
