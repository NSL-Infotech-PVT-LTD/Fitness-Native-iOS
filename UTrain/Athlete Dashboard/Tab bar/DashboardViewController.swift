//
//  DashboardViewController.swift
//  UTrain
//
//  Created by Yudhisther on 25/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit
import SideMenuSwift

class DashboardViewController: UIViewController {

    @IBOutlet weak var roundTabImgContainer: UIView?
    var tabBarReference:AthleteDashTabBarVC?
    
    //MARK:- View life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        roundTabImgContainer?.layer.cornerRadius = 25
        
        roundTabImgContainer?.layer.shadowColor = UIColor.gray.cgColor
        roundTabImgContainer?.layer.shadowRadius = 1
        roundTabImgContainer?.layer.shadowOpacity = 1
        roundTabImgContainer?.layer.shadowOffset = CGSize(width: 5, height: 5)
        roundTabImgContainer?.clipsToBounds = true
        roundTabImgContainer?.layer.borderColor = UIColor.lightGray.cgColor
        roundTabImgContainer?.layer.borderWidth = 5
        
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TabBar"{
            
            tabBarReference = segue.destination as? AthleteDashTabBarVC
        }
        
    }
    
    @IBAction func sideMenuBtnAction(_ sender: Any) {
        sideMenuController?.revealMenu()
        
    }
    
    @IBAction func homeTabBarAction(_ sender: Any) {
        tabBarReference?.selectedIndex = 0
    }
    
   
    @IBAction func messageTabBarAction(_ sender: Any) {
        tabBarReference?.selectedIndex = 1
    }
    
    @IBAction func bookingTabBarAction(_ sender: Any) {
        tabBarReference?.selectedIndex = 2
    }
    
    @IBAction func notificationTabBarAction(_ sender: Any) {
        tabBarReference?.selectedIndex = 3
    }
}
