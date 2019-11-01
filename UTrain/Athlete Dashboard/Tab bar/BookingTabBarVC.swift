//
//  BookingTabBarVC.swift
//  UTrain
//
//  Created by Yudhisther on 25/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class BookingTabBarVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    class func instance()-> BookingTabBarVC? {
        let storyboard = UIStoryboard(name: "AthleteDashboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "BookingTabBarVC") as? BookingTabBarVC
        return controller
    }
}
