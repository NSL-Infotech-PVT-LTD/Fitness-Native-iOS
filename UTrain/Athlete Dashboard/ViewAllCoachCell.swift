//
//  ViewAllCoachCell.swift
//  UTrain
//
//  Created by osx on 30/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class ViewAllCoachCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView?
    @IBOutlet weak var coachNameLbl: UILabel?
    @IBOutlet weak var contentContainerView: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
