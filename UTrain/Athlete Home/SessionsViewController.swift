//
//  SessionsViewController.swift
//  UTrain
//
//  Created by osx on 27/09/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class SessionsViewController: UIViewController {
    
    //MARK:- View Life-Cycle
    override func viewDidLoad(){
        super.viewDidLoad()

    }
    
    class func instance()->SessionsViewController?{
        let storyboard = UIStoryboard(name: "AthleteHomeScreen", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SessionsViewController") as? SessionsViewController
        
        return controller
    }
    

}
