//
//  AthleteDashTabBarVC.swift
//  UTrain
//
//  Created by Yudhisther on 25/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class AthleteDashTabBarVC: UITabBarController {

    let firstVC = UINavigationController(rootViewController:AthleteDashboardVC.instance() ?? UIViewController())
    let secondVC = UINavigationController(rootViewController:MessageTabViewController.instance() ?? UIViewController())
    let thirdVC = UINavigationController(rootViewController:BookingTabBarVC.instance() ?? UIViewController())
    let fourthVC = UINavigationController(rootViewController:NotificationTabBarVC.instance() ?? UIViewController())



    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewControllers = [firstVC, secondVC, thirdVC, fourthVC]
    }
    
    

   
}
