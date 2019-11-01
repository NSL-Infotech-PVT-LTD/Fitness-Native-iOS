//
//  AthleteLoginViewController.swift
//  UTrain
//
//  Created by osx on 03/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKLoginKit
import FBSDKCoreKit

class AthleteLoginViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var emailLoginView: UIView?
    @IBOutlet weak var fbLoginView: UIView?
    
    //MARK:- View Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        theme()
    }
    
    func theme(){
        emailLoginView?.layer.cornerRadius = 10
        emailLoginView?.clipsToBounds = true
        
        fbLoginView?.layer.cornerRadius = 10
        fbLoginView?.clipsToBounds = true
    }
    
    @IBAction func loginEmailActionBtn(_ sender: Any) {
        guard let controller = EmailLoginViewController.instance() else { return
        }
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @IBAction func facebookLoginAction(_ sender: Any) {
        if let token = AccessToken.current{
            guard let controller = ForgetPasswordViewController.instance() else{
                return
            }
            self.navigationController?.pushViewController(controller, animated: true)
        } else{
            let manager = LoginManager()
            manager.logIn(permissions: [Permission.publicProfile], viewController: self) { (loginResult) in
                switch loginResult {
                case .failed(let errorr):
                    print("the errorr is:-\(errorr)")
                case .cancelled:
                    print("User cancelled login")
                case .success(let grantedPermiss, let declinedPermiss, let accessTokn) :
                    print("logged in")
                    guard let controller = ForgetPasswordViewController.instance() else{
                        return
                    }
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
            
        }
        
    }
    
    @IBAction func signupActionBtn(_ sender: Any) {
        guard let controller = AthleteSignupViewController.instance() else{
            return
        }
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
    @IBAction func backAction(_ sender: Any) {
        guard let controller = ViewController.instance() else{
            return
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    class func instance()-> AthleteLoginViewController?{
        let storyboard = UIStoryboard(name: "LoginModule", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AthleteLoginViewController") as? AthleteLoginViewController
        return controller
    }

}
