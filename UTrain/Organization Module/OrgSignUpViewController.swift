//
//  OrgSignUpViewController.swift
//  UTrain
//
//  Created by osx on 04/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class OrgSignUpViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var profileImage: UIImageView?
    var imagePicker = UIImagePickerController()
    let defImgView = UIImageView()

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var bioTF: UITextField!
    @IBOutlet weak var expertiseYearTF: UITextField!
    @IBOutlet weak var hourlyRateTF: UITextField!
    @IBOutlet weak var startBusinessHour: UITextField!
    @IBOutlet weak var endBusinessHour: UITextField!
    
    @IBOutlet weak var orgLblView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    
    @IBOutlet weak var passwordEyeIcon: UIImageView?
    var iconClick = true
    
    //MARK:- View Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        hideKeyboard()
        phoneTF.delegate = self
        passwordTF.delegate = self
        hourlyRateTF.delegate = self
        
        orgLblView?.layer.cornerRadius = 10
        orgLblView?.clipsToBounds = true
        imageContainerView?.layer.cornerRadius = 10
        imageContainerView?.clipsToBounds = true

    }
    
    @IBAction func imageUploadAction(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)

        
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    class func instance()-> OrgSignUpViewController?{
        let storyboard = UIStoryboard(name: "OrganizationModule", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "OrgSignUpViewController") as? OrgSignUpViewController
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
    self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Button actions
    @IBAction func twoMoreStepActionBtn(_ sender: Any) {
        if !validateFields(){
            return
        }
        else {
            guard let controller = SummaryOfServiceVC.instance()else{
                return
            }
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
       
    }
    
    
    //HIDE KEYBOARD
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardByTappingOutside))
        
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboardByTappingOutside() {
        self.view.endEditing(true)
    }
    
    //UIAlertController
    func alert(message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func signup(){
        api.delegate = self
        var params = [String:Any]()
        params = ["name" : nameTF?.text ?? "",
                  "email": emailTF?.text ?? "",
                  "password":passwordTF?.text ?? "",
                  "phone"  : phoneTF?.text ?? "",
                  "location": locationTF?.text ?? "",
                  "latitude": "30",
                  "longitude": "25",
                  "bio": "25",
                  
//                  "service_ids": [{"ide":1,"isSelected":true,"name":"CARDIO FITNESS","price":"23"},
//                    {"id":2,"isSelected":true,"name":"PRE NATAL EXERCISE","price":"12"},
//                    {"id":3,"isSelected":true,"name":"SENIOR FITNESS TRAINING","price":"45"},
//                    {"id":4,"isSelected":true,"name":"STRENGTH TRAINING","price":"50"}],
                  "expertise_years": "25",
                  "hourly_rate": "25",
                  "business_hour_starts": "25",
                  "business_hour_ends": "25",
                  "device_type": "25",
                  "device_token": "25"]
            showIndicator()
            api.createAccount(url: API_ENDPOINTS.SIGNUP_ORGANISER.rawValue, params: params, image: profileImage!.image!, viewController: self) { (response) in
            
            print(response)
        }
        
	    }
    
    
    //MARK:- Validations
    func checkName(text: String) -> Bool{
        
        if text == ""{
            alert(message: "Enter Name")
            return false
        }
        
        return true
    }
    
    
    func checkValidateEmail(text: String) -> Bool{
        
        if text == ""{
            alert(message: "Enter Email")
            return false
        }
        if !text.isValidEmail{
            alert(message: "Not a valid Email")
            return false
        }
        return true
    }
    
    func checkValidatePassword(text: String) -> Bool{
        if text == ""{
            alert(message: "Enter Password")
            return false
        }
        return true
    }
    
    
    func checkPhone(text: String) -> Bool{
        
        if text == ""{
            alert(message: "Enter Phone")
            return false
        }
        
        return true
    }
    
    func checkLocation(text: String) -> Bool{
        
        if text == ""{
            alert(message: "Enter Location")
            return false
        }
        
        return true
    }
    
    func checkBio(text: String) -> Bool{
        
        if text == ""{
            alert(message: "Enter Bio")
            return false
        }
        
        return true
    }
    
    func checkExpertiseYear(text: String) -> Bool{
        
        if text == ""{
            alert(message: "Enter Expertise years")
            return false
        }
        return true
    }
    
    func checkHourlyRate(text: String) -> Bool{
        
        if text == ""{
            alert(message: "Enter hourly rate")
            return false
        }
        return true
    }
    
    func checkImage(imgView:UIImageView) -> Bool{
        if imgView.image == nil {
            alert(message: "Upload Image")
            return false
        }
        return true
    }
    
   
    func validateFields() -> Bool{
        let isName = checkName(text: nameTF?.text ?? "")
        let isEmailVerified = checkValidateEmail(text: emailTF?.text ?? "")
        let phone =  checkPhone(text: phoneTF?.text ?? "")
        let location = checkLocation(text: locationTF?.text ?? "")
        let isPassValid =  checkValidatePassword(text: passwordTF?.text ?? "")
        let isBio =  checkBio(text: bioTF?.text ?? "")
        
        let isExpertiseYr =  checkExpertiseYear(text: expertiseYearTF?.text ?? "")
        let isHourlyRate =  checkHourlyRate(text: hourlyRateTF?.text ?? "")
        let isImageUploaded = checkImage(imgView: profileImage ?? defImgView)



        
        if !isName || !isEmailVerified || !phone || !location || !isPassValid || !isBio || !isExpertiseYr || !isHourlyRate || isImageUploaded {
            return false
        }
        return true
    }
    
    
}

extension OrgSignUpViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        profileImage?.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension OrgSignUpViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        var maxLength = Int()
        
        if textField == phoneTF{
            maxLength = 10
        } else if textField == passwordTF{
            maxLength = 10
        } else if textField == hourlyRateTF{
            maxLength = 3
        }
        
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
//        let maxLength = 5
//        let currentString: NSString = textField.text! as NSString
//        let newString: NSString =
//            currentString.replacingCharacters(in: range, with: string) as NSString
//
//        return newString.length <= maxLength
//
    
    }
    
}
