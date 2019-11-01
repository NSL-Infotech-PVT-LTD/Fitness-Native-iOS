//
//  CoachLoginViewController.swift
//  UTrain
//
//  Created by Yudhisther on 07/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class CoachLoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField?
    @IBOutlet weak var passwordTF: UITextField?
    
    @IBOutlet weak var emailView: UIView?
    @IBOutlet weak var loginBtnView: UIView?
    @IBOutlet weak var passwordView: UIView?
    
    var dataSource : AthleteLoginModel?
    
    @IBOutlet weak var passwordEyeIcon: UIImageView?
    var iconClick = true
    
    //MARK:- View Life-Cycle
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
    

    class func instance()-> CoachLoginViewController?{
        let storyboard = UIStoryboard(name: "CoachLogin", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CoachLoginViewController") as? CoachLoginViewController
        return controller
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
    
    @IBAction func backAction(_ sender: Any) {
        guard let controller = ViewController.instance() else{
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
    
    @IBAction func loginActionBtn(_ sender: Any) {
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
                //print("kokokokokokokokokokokokokokokoko")
                guard let controller = AthleteDashboardVC.instance()
                    else{
                        return
                }
                self.navigationController?.pushViewController(controller, animated: true)
                
                self.dataSource = model
            }
        }
        
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
    
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardByTappingOutside))
        
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboardByTappingOutside() {
        self.view.endEditing(true)
    }
    
    
    @IBAction func signupActionBtn(_ sender: Any) {
        guard let controller = CoachSignupViewController.instance() else{
            return
        }
        self.navigationController?.pushViewController(controller, animated: true)
        
        
    }
    
}
