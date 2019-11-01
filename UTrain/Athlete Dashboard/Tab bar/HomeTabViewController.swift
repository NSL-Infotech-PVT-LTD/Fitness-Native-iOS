//
//  HomeTabViewController.swift
//  UTrain
//
//  Created by Yudhisther on 25/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class HomeTabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    class func instance()-> HomeTabViewController? {
        let storyboard = UIStoryboard(name: "AthleteDashboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeTabViewController") as? HomeTabViewController
        return controller
    }

}
