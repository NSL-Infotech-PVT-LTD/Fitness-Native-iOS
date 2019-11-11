//
//  AthleteDashbSpacesCell.swift
//  UTrain
//
//  Created by osx on 30/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class AthleteDashbSpacesCell: UITableViewCell {

    @IBOutlet weak var spacesImgContainer: UIView?
    @IBOutlet weak var spacesImgView: UIImageView?
    
    @IBOutlet weak var nameLbl: UILabel?

    @IBOutlet weak var locationLbl: UILabel?
    @IBOutlet weak var distanceLbl: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
