//
//  AthleteDashbEventsCell.swift
//  UTrain
//
//  Created by osx on 30/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class AthleteDashbEventsCell: UITableViewCell {
    @IBOutlet weak var eventsImgView: UIImageView?
    @IBOutlet weak var eventsImgContainer: UIView?
    
    @IBOutlet weak var locationLbl: UILabel?
    
    @IBOutlet weak var startDate: UILabel?
    
    @IBOutlet weak var endDate: UILabel?
    @IBOutlet weak var distanceLbl: UILabel?
    
    @IBOutlet weak var timeLbl: UILabel?
    @IBOutlet weak var priceLbl: UILabel?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
