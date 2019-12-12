//
//  LoginVC.swift
//  Utrain
//
//  Created by NetScape Labs on 10/12/19.
//  Copyright © 2019 NetScape Labs. All rights reserved.
//

import UIKit
import Pulley

class LoginVC: UIViewController {
   
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
    }
    

    @IBAction func logInOnPress(_ sender: UIButton) {
//        if let vc = ViewControllerHelper.getViewController(ofType: .DashboardVC) as? DashboardVC {
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        let mainContentVC = UIStoryboard(name: "Coach", bundle: nil).instantiateViewController(withIdentifier: "FindSessionsVC")
        
        let drawerContentVC = UIStoryboard(name: "Coach", bundle: nil).instantiateViewController(withIdentifier: "DrawerContentVC")
        
        let pulleyController = PulleyViewController(contentViewController: mainContentVC, drawerViewController: drawerContentVC)
        
        self.present(pulleyController, animated: true, completion: nil)
    }
    
    @IBAction func forGotOnPress(_ sender: Any) {
        if let vc = ViewControllerHelper.getViewController(ofType: .ForgotPasswordVc) as? ForgotPasswordVc {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func signUpOnPress(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .CompleateProfile) as? CompleateProfile {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func passwordHideUnhideOnPress(_ sender: UIButton) {
        if(iconClick == true) {
            txtPassword.isSecureTextEntry = false
        } else {
            txtPassword.isSecureTextEntry = true
        }
        
        iconClick = !iconClick
    }
}
