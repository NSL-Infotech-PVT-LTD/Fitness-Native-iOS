//
//  AthleteDashbSessionCell.swift
//  UTrain
//
//  Created by osx on 30/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class AthleteDashbSessionCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel?
    @IBOutlet weak var addressLbl: UILabel?
    @IBOutlet weak var startDate: UILabel?
    @IBOutlet weak var enddate: UILabel?
    @IBOutlet weak var timeLbl: UILabel?
    @IBOutlet weak var distanceLbl: UILabel?
    @IBOutlet weak var priceLbl: UILabel?
    
    @IBOutlet weak var sessionImgContainer: UIView?
    @IBOutlet weak var sessionImgView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
