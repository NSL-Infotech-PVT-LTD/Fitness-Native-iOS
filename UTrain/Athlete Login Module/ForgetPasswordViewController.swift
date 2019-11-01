//
//  ForgetPasswordViewController.swift
//  UTrain
//
//  Created by osx on 03/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    class func instance()-> ForgetPasswordViewController?{
        let storyboard = UIStoryboard(name: "LoginModule", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as? ForgetPasswordViewController
        return controller
    }

    
    @IBAction func goBackAction(_ sender: Any) {
        if let token = AccessToken.current{
            AccessToken.current = nil
            guard let controller = AthleteLoginViewController.instance() else{
                return
            }
            self.navigationController?.pushViewController(controller, animated: true)
            
        }

        //self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backActionBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitActionBtn(_ sender: Any) {
        if emailTF?.text?.count == 0{
            alert(message: "Enter Email")
            return
        }
        else if !(emailTF?.text?.isValidEmail)!{
            alert(message: "Not a valid Email")
            return
            
        } else{
            submit()
        }
        
    }
   
    func submit(){
        api.delegate = self
        var params = [String:Any]()
        params = ["email": emailTF?.text ?? ""]
        showIndicator()
        api.forgetPassword(url: API_ENDPOINTS.FORGOT_PASSWORD.rawValue, params: params, viewController: self) { (model) in
            print(model)
        }
    }
    
    //UIAlertController
    func alert(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
        
    }
}
