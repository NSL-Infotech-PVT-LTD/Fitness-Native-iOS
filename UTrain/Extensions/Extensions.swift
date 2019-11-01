//
//  Extensions.swift
//  UTrain
//
//  Created by osx on 01/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD
import CoreLocation

let api = API()

extension UIView{
    func rounded(){
        //self.clipsToBounds = true
        self.layer.cornerRadius = 25
        //self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        //shadow
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
       // self.layer.masksToBounds = false
        //self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        //self.layer.shouldRasterize = true
        //self.layer.rasterizationScale = UIScreen.main.scale
    }
}

extension String{
    var isPasswordValid: Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$")
        return passwordTest.evaluate(with: self)
    }
    
    var isValidEmail: Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

extension UIViewController : APIsDelegate{
    func callBackFromAPI() {
        DispatchQueue.main.async {
            self.hideIndicator()
        }
    }
    
    func alertWindow(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true)
        
    }
    
    //MARK: SVProgressHUD
    func showIndicator()
    {
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
    }
    
    func hideIndicator() {
        if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
        }
    }
}
