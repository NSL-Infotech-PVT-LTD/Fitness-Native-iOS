//
//  CompleateProfile.swift
//  Utrain
//
//  Created by NetScape Labs on 10/12/19.
//  Copyright © 2019 NetScape Labs. All rights reserved.
//

import UIKit

class CompleateProfile: UIViewController {

    @IBOutlet weak var allFeildsContainerView: UIView!
    @IBOutlet weak var txtHourlyRate: UITextField!
    @IBOutlet weak var txtTrainingServiceDetails: UITextField!
    @IBOutlet weak var txtExperienceDetails: UITextField!
    @IBOutlet weak var txtExpertise: UITextField!
    @IBOutlet weak var txtProfession: UITextField!
    @IBOutlet weak var txtEndBusinessHour: UITextField!
    @IBOutlet weak var txtStartBusinessHour: UITextField!
    @IBOutlet weak var txtBio: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        // Set Corner Radius
//        self.allFeildsContainerView.roundCorners([.topLeft,.topRight], radius: 40.0)
//        self.allFeildsContainerView.shadowColor = .darkGray
//        self.allFeildsContainerView.shadowRadius = 8
//        self.allFeildsContainerView.shadowOffset = CGSize(width: 3, height: 3)
//        self.allFeildsContainerView.layoutIfNeeded()
    }
    
    // MARK: Current Location
    @IBAction func getCurrentLocationOnPress(_ sender: UIButton) {
    }
    
    
    @IBAction func backOnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func moreStepOnPress(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .ChooseSportsVC) as? ChooseSportsVC{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func passwordHideUnHideOnPress(_ sender: UIButton) {
        if(iconClick == true) {
            txtPassword.isSecureTextEntry = false
        } else {
            txtPassword.isSecureTextEntry = true
        }
        
        iconClick = !iconClick
    }
    
}
