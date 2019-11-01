//
//  SummaryOfServiceVC.swift
//  UTrain
//
//  Created by osx on 15/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class SummaryOfServiceVC: UIViewController {

    @IBOutlet weak var containerView: UIView?
    
    //MARK:- View Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView?.rounded()
    }
    
    class func instance()-> SummaryOfServiceVC?{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SummaryOfServiceVC") as? SummaryOfServiceVC
        return controller
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addServiceActionBtn(_ sender: Any) {
        guard let controller = SelectServiceVC.instance()else{
            return
        }
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
   

}
