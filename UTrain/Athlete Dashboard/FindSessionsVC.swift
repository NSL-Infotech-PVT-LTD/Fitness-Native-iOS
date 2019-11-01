//
//  FindSessionsVC.swift
//  UTrain
//
//  Created by osx on 01/11/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit
import GoogleMaps

class FindSessionsVC: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    class func instance()-> FindSessionsVC?{
        let storyboard = UIStoryboard(name: "AthleteDashboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FindSessionsVC") as? FindSessionsVC
        return controller
    }


}
