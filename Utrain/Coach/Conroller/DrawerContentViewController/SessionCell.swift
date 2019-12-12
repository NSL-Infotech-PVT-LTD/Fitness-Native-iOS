//
//  SessionCell.swift
//  Utrain
//
//  Created by NetScape Labs on 12/12/19.
//  Copyright © 2019 NetScape Labs. All rights reserved.
//

import UIKit

class SessionCell: UITableViewCell {
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgSession: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
