//
//  SideMenuVC.swift
//  UTrain
//
//  Created by osx on 04/11/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit
import SideMenuSwift

class SideMenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func dashboardActionBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AthleteDashboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    @IBAction func transactionActionBtn(_ sender: Any) {
    }
    
    @IBAction func notificationActionBtn(_ sender: Any) {
    }
    @IBAction func aboutusActionBtn(_ sender: Any) {
    }
    @IBAction func rateUsActionBtn(_ sender: Any) {
    }
    
    @IBAction func settingActionBtn(_ sender: Any) {
    }
}
