//
//  CardPaymentVC.swift
//  Utrain
//
//  Created by NetScape Labs on 10/12/19.
//  Copyright © 2019 NetScape Labs. All rights reserved.
//

import UIKit

class CardPaymentVC: UIViewController {

    @IBOutlet weak var txtHolderName: UITextField!
    @IBOutlet weak var txtCVV: UITextField!
    @IBOutlet weak var txtMonthExp: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mark : TextFeild Delegate
        self.txtCardNumber.delegate = self
        self.txtMonthExp.delegate = self
        self.txtCVV.delegate = self
        
        
    self.txtCardNumber.addTarget(self, action: #selector(didChangeText(textField:)), for: .editingChanged)
    }
    @objc func didChangeText(textField:UITextField) {
        txtCardNumber.text = self.modifyCreditCardString(creditCardString: textField.text!)
    }

    @IBAction func backOnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
  
    @IBAction func confrmBookingOnPress(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .DashboardVC) as? DashboardVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func modifyCreditCardString(creditCardString : String) -> String {
        let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()
        
        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0) {
            for i in 0...arrOfCharacters.count-1 {
                modifiedCreditCardString.append(arrOfCharacters[i])
                if((i+1) % 4 == 0 && i+1 != arrOfCharacters.count){
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        return modifiedCreditCardString
    }
}

// MARK : Card TextField

extension CardPaymentVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text ?? "").count + string.count - range.length
        if(textField == txtCardNumber) {
            return newLength <= 19
        }else if textField == txtMonthExp {
            let currentText = textField.text! as NSString
            let updatedText = currentText.replacingCharacters(in: range, with: string)
            
            if string == "" {
                
                if textField.text?.count == 3
                {
                    textField.text = "\(updatedText.prefix(1))"
                    return false
                }
                
                return true
            }
            
            if updatedText.count == 5
            {
                
                expDateValidation(dateStr:updatedText)
                return updatedText.count <= 5
            } else if updatedText.count > 5
            {
                return updatedText.count <= 5
            } else if updatedText.count == 1{
                if updatedText > "1"{
                    return updatedText.count < 1
                }
            }  else if updatedText.count == 2{   //Prevent user to not enter month more than 12
                if updatedText > "12"{
                    return updatedText.count < 2
                }
            }
            
            textField.text = updatedText
            
            
            if updatedText.count == 2 {
                
                textField.text = "\(updatedText)/"   //This will add "/" when user enters 2nd digit of month
            }
            
            return false
        }else if textField == txtCVV {
            if textField.text!.count == 3{
                textField.resignFirstResponder()
                txtHolderName.becomeFirstResponder()
            }
            return false
        }
        return true
    }
}
