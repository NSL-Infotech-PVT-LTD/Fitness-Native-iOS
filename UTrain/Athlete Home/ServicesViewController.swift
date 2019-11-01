//
//  ServicesViewController.swift
//  UTrain
//
//  Created by osx on 01/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class ServicesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    class func instance()->ServicesViewController?{
        let storyboard = UIStoryboard(name: "AthleteHomeScreen", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ServicesViewController") as? ServicesViewController
        
        return controller
    }


}
