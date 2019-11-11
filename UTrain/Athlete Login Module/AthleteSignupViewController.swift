//
//  AthleteSignupViewController.swift
//  UTrain
//
//  Created by osx on 03/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class AthleteSignupViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var profilePcView: UIView?
    @IBOutlet weak var profileImage: UIImageView?
    
    @IBOutlet weak var usernameView: UIView?
    @IBOutlet weak var emailView: UIView?
    @IBOutlet weak var phoneNumView: UIView?
    @IBOutlet weak var addressView: UIView?
    @IBOutlet weak var passwordView: UIView?
    @IBOutlet weak var signupBtnView: UIView?
    
    @IBOutlet weak var nameTF: UITextField?
    @IBOutlet weak var emailTF: UITextField?
    @IBOutlet weak var phoneTF: UITextField?
    @IBOutlet weak var addressTF: UITextField?
    @IBOutlet weak var passwordTF: UITextField?
    @IBOutlet weak var passwordEyeIcon: UIImageView?
    
    //MARK:- Variables
    var imagePicker = UIImagePickerController()
    var iconClick = true
    var currentLocation  : CLLocation!
    
        var placesClient     : GMSPlacesClient!
    
        var gmsMapView       = GMSMapView()
    
        var locationManager  : CLLocationManager!
    
        var cordinates       : CLLocationCoordinate2D?
    
        let marker           = GMSMarker()
    
        var location         : Int?
    

    
    //MARK:- View Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        theme()
        imagePicker.delegate = self
        hideKeyboard()
        phoneTF?.delegate = self
        passwordTF?.delegate = self
    }
    
    func theme(){
        profilePcView?.layer.cornerRadius = 10
        profilePcView?.clipsToBounds = true
        
        usernameView?.layer.cornerRadius = 10
        usernameView?.clipsToBounds = true
        
       
        emailView?.layer.cornerRadius = 10
        emailView?.clipsToBounds = true
        
        phoneNumView?.layer.cornerRadius = 10
        phoneNumView?.clipsToBounds = true
        
        addressView?.layer.cornerRadius = 10
        addressView?.clipsToBounds = true
        
        passwordView?.layer.cornerRadius = 10
        passwordView?.clipsToBounds = true
        
        signupBtnView?.layer.cornerRadius = 10
        signupBtnView?.clipsToBounds = true
        
    }
    //MARK:- Class Instance
    class func instance()-> AthleteSignupViewController?{
        let storyboard = UIStoryboard(name: "LoginModule", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AthleteSignupViewController") as? AthleteSignupViewController
        return controller
    }
    
    @IBAction func getAddressActionBtn(_ sender: Any) {
        print(currentLocation.coordinate.latitude)
        self.getAddressFromLatLon(pdblLatitude: "\(currentLocation.coordinate.latitude)", withLongitude: "\(currentLocation.coordinate.longitude)")
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
    
    @IBAction func imagePickAction(_ sender: Any) {
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
    
    
    @IBAction func signInAction(_ sender: Any) {
        guard let controller = EmailLoginViewController.instance()else{
            return
        }
      self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @IBAction func signupAction(_ sender: Any) {
        if !validateFields(){
            return
        }
        else {
            signup()
        }
    }
    
    func signup(){
        api.delegate = self
        var params = [String:String]()
        params = ["name": nameTF?.text ?? "",
                  "email": emailTF?.text ?? "",
                  "password":passwordTF?.text ?? "",
                  "phone": phoneTF?.text ?? "",
                  "address": addressTF?.text ?? "",
                  "latitude": "30",
                  "longitude": "25",
                  "device_type": "ios",
                  "device_token": "12345abcde"]
        showIndicator()
        
        api.createAccount(url: API_ENDPOINTS.SIGNUP_ATHLETE.rawValue, params: params, image: profileImage!.image!, viewController: self) { (respo) in
           print(respo)
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
    
    func checkPhone(text: String) -> Bool{
        
        if text == ""{
            alert(message: "Enter Phone")
            return false
        }
        
        return true
    }
    
    func checkAddress(text: String) -> Bool{
        
        if text == ""{
            alert(message: "Enter Address")
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
    
    func validateFields() -> Bool{
        let isName = checkName(text: nameTF?.text ?? "")
        let isEmailVerified = checkValidateEmail(text: emailTF?.text ?? "")
        let phone =  checkPhone(text: phoneTF?.text ?? "")
        let address = checkAddress(text: addressTF?.text ?? "")
        let isPassValid =  checkValidatePassword(text: passwordTF?.text ?? "")
       
        if !isName || !isEmailVerified || !phone || !address || !isPassValid {
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
    
    
}

extension AthleteSignupViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        profileImage?.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            // imageViewPic.contentMode = .scaleToFill
//            imageViewPic.image = pickedImage
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
    
}

extension AthleteSignupViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var maxLength = Int()
        
        if textField == phoneTF{
            maxLength = 10
        } else if textField == passwordTF{
            maxLength = 10
        }
        
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
   }
}



extension AthleteSignupViewController: CLLocationManagerDelegate, GMSMapViewDelegate{
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        let lon: Double = Double("\(pdblLongitude)")!
    
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country)
                    print(pm.locality)
                    print(pm.subLocality)
                    print(pm.thoroughfare)
                    print(pm.postalCode)
                    print(pm.subThoroughfare)
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    self.addressTF?.text = addressString
                    print(addressString)
                }
        })
        
    }
    
    func getCurrentLatLong(){
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            currentLocation = locManager.location
            
        }
    }
}
