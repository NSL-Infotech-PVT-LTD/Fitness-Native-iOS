//
//  EmailLoginViewController.swift
//  UTrain
//
//  Created by osx on 03/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit
import IQKeyboardManager
import SideMenuSwift


class EmailLoginViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var emailTF:    UITextField?
    @IBOutlet weak var passwordTF: UITextField?
    
    @IBOutlet weak var emailView: UIView?
    @IBOutlet weak var passwordView: UIView?
    @IBOutlet weak var loginBtnView: UIView?
    
    @IBOutlet weak var passwordEyeIcon: UIImageView?
    var dataSource :AthleteLoginModel?
    var iconClick = true

    
    //MARK:- View life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        theme()
    }
    
      func theme(){
        emailView?.layer.cornerRadius = 10
        emailView?.clipsToBounds = true
        passwordView?.layer.cornerRadius = 10
        passwordView?.clipsToBounds = true
        loginBtnView?.layer.cornerRadius = 10
        loginBtnView?.clipsToBounds = true
    }

    class func instance()-> EmailLoginViewController? {
        let storyboard = UIStoryboard(name: "LoginModule", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EmailLoginViewController") as? EmailLoginViewController
        return controller
    }
    
    //MARK:- Button Actions
    @IBAction func loginAction(_ sender: Any) {
        if !validateFields(){
            return
        }
        else {
        login()
        }
    }
    
    func login(){
        api.delegate = self
        var params = [String:Any]()
        params = ["email": emailTF?.text ?? "",
                  "password":  passwordTF?.text ?? "",
                  "device_type": "ios",
                  "device_token": "1234rfvc"]
        
        showIndicator()
        api.loginUser(url: API_ENDPOINTS.LOGIN.rawValue, params: params, viewController: self) { (model) in
            if model != nil{
//                UserDefaults.standard.set(params, forKey: "token")
//                if (UserDefaults.standard.value(forKey: "userData") as? [String:Any]) == nil{
//                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                    let loginViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//                    let navigationController = UINavigationController(rootViewController: loginViewController)
//                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
//                    appdelegate.window!.rootViewController = navigationController
//                }else{
//                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenuController") as! SideMenuController
//                    let navigationController = UINavigationController(rootViewController: nextViewController)
//                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
//                    appdelegate.window!.rootViewController = navigationController
//                }
               
//
                let storyboard = UIStoryboard(name: "AthleteDashboard", bundle: nil)
               let controller = storyboard.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuController
                self.navigationController?.pushViewController(controller!, animated: true)

                self.dataSource = model
            }
        }
        
    }
    
    @IBAction func eyeIconClickAction(_ sender: Any) {
        if(iconClick == true) {
            passwordTF?.isSecureTextEntry = false
            passwordEyeIcon?.image = UIImage(named: "eye")
        } else {
            passwordTF?.isSecureTextEntry = true
            passwordEyeIcon?.image = UIImage(named: "closedEye")
        }
        
        iconClick = !iconClick
        
    }
    
           // UserDefaults.standard.set(params, forKey: "userData")
            
//            if (UserDefaults.standard.value(forKey: "userData") as? [String:Any]) == nil{
//                let storyBoard : UIStoryboard = UIStoryboard(name: "LoginModule", bundle:nil)
//                let loginViewController = storyBoard.instantiateViewController(withIdentifier: "EmailLoginViewController") as! EmailLoginViewController
//                let navigationController = UINavigationController(rootViewController: loginViewController)
//                let appdelegate = UIApplication.shared.delegate as! AppDelegate
//                appdelegate.window!.rootViewController = navigationController
//            }else{
//                let storyBoard : UIStoryboard = UIStoryboard(name: "LoginModule", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as! ForgetPasswordViewController
//                let navigationController = UINavigationController(rootViewController: nextViewController)
//                let appdelegate = UIApplication.shared.delegate as! AppDelegate
//                appdelegate.window!.rootViewController = navigationController
//
//            }
//        }
//
//    }
    
    @IBAction func backActionBtn(_ sender: Any) {
        guard let controller = AthleteLoginViewController.instance() else{
            return
        }
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @IBAction func forgetPasswordAction(_ sender: Any) {
        guard let controller = ForgetPasswordViewController.instance() else{
            return
        }
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    @IBAction func signupAction(_ sender: Any) {
        guard let controller = AthleteSignupViewController.instance() else{
            return
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK:- Validations
    func checkValidateEmail(text: String) -> Bool{
        
        if text == ""{
            alert(message: "Enter Email")
            //errorLbl?.text = "Enter Email"
            return false
        }
        if !text.isValidEmail{
            alert(message: "Not a valid Email")
            //errorLbl?.text = "Not a valid Email"
            return false
        }
       // errorLbl?.text = ""
        return true
    }
    
    func checkValidatePassword(text: String) -> Bool{
        
        if text == ""{
            alert(message: "Enter Password")
           // passwordErrorLbl?.text = "Enter Password"
            return false
        }
        //passwordErrorLbl?.text = ""
        return true
    }
    
    func validateFields() -> Bool{
        
        let isEmailVerified = checkValidateEmail(text: emailTF?.text ?? "")
        let isPassValid =  checkValidatePassword(text: passwordTF?.text ?? "")
        if !isEmailVerified || !isPassValid{
            return false
        }
        return true
    }
    //UIAlertController
    func alert(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
        
    }
    
    //keyboard hide
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardByTappingOutside))
        
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboardByTappingOutside() {
        self.view.endEditing(true)
    }
    
}
