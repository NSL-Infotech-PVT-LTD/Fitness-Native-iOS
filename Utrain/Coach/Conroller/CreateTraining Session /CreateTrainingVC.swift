//
//  CreateTrainingVC.swift
//  Utrain
//
//  Created by NetScape Labs on 13/12/19.
//  Copyright © 2019 NetScape Labs. All rights reserved.
//

import UIKit

class CreateTrainingVC: UIViewController {

    @IBOutlet weak var scrolliew: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    @IBAction func backOnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func locationBtnOnPress(_ sender: UITapGestureRecognizer) {
        if let vc = ViewControllerHelper.getViewController(ofType: .LocationOnMapVC) as? LocationOnMapVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func uploadOnPress(_ sender: UITapGestureRecognizer) {
    }
    
}
