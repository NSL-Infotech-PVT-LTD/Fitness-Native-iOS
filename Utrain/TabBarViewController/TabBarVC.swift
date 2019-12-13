//
//  TabBarVC.swift
//  Utrain
//
//  Created by NetScape Labs on 13/12/19.
//  Copyright © 2019 NetScape Labs. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    var kBarHeight = 80
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.layer.borderWidth = 0.50
        tabBarController?.tabBar.layer.borderColor = UIColor.clear.cgColor
        tabBarController?.tabBar.clipsToBounds = true
        let backgroundImage = UIImageView(image: #imageLiteral(resourceName: "TabBack"))
        backgroundImage.frame = backgroundImage.bounds
        tabBarController?.tabBar.backgroundImage = #imageLiteral(resourceName: "TabBack")
        tabBarController?.tabBar.clipsToBounds = true
        tabBarController?.tabBar.roundCorners([.topLeft,.topRight], radius: 10.0)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
       
    }
  
}
