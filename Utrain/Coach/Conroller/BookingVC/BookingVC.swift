//
//  BookingVC.swift
//  Utrain
//
//  Created by NetScape Labs on 10/12/19.
//  Copyright © 2019 NetScape Labs. All rights reserved.
//

import UIKit

class BookingVC: UIViewController {

    @IBOutlet weak var txtEndTime: UITextField!
    @IBOutlet weak var txtStartTime: UITextField!
    @IBOutlet weak var txtEnddate: UITextField!
    @IBOutlet weak var txtStartdate: UITextField!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblVenue: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var viewNav: UIView!
    
    //Uidate picker
    var datePicker = UIDatePicker()
    var dateFormatter = DateFormatter()
    var toolBar = UIToolbar()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewNav.roundCorners([.bottomRight,.bottomLeft], radius: 10.0)
        // Mark : TextFeild Delegate
        self.txtEndTime.delegate = self
        self.txtEnddate.delegate = self
        self.txtStartTime.delegate = self
        self.txtStartdate.delegate = self
        
        txtEndTime.inputView    = datePicker
        txtEnddate.inputView      = datePicker
        txtStartTime.inputView    = datePicker
        txtStartdate.inputView      = datePicker
        
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolBar.setItems([doneButton], animated: true)
        txtEndTime.inputAccessoryView   = toolBar
        txtEnddate.inputAccessoryView     = toolBar
        txtStartTime.inputAccessoryView   = toolBar
        txtStartdate.inputAccessoryView     = toolBar
    }
    
    @IBAction func backOnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ContinueToPayoNpress(_ sender: UITapGestureRecognizer) {
        if let vc = ViewControllerHelper.getViewController(ofType: .CardPaymentVC) as? CardPaymentVC{
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    

    @objc func doneButtonTapped() {
        if txtEndTime.isFirstResponder {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "HH:mm"
            datePicker.setDate(Date(), animated: false)
            txtEndTime.text = dateFormatter.string(from: datePicker.date)
        }
        if txtEnddate.isFirstResponder {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "YYYY/MM/dd"
            datePicker.setDate(Date(), animated: false)
            txtEnddate.text = dateFormatter.string(from: datePicker.date)
        }
        if txtStartTime.isFirstResponder {
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .medium
            dateFormatter.dateFormat = "HH:mm"
            txtStartTime.text = dateFormatter.string(from: datePicker.date)
        }
        if txtStartdate.isFirstResponder {
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .medium
            dateFormatter.dateFormat = "YYYY/MM/dd"
            datePicker.setDate(Date(), animated: false)
            txtStartdate.text = dateFormatter.string(from: datePicker.date)
        }
        self.view.endEditing(true)
    }
    @objc func cancelClick(textFeild:UITextField) {
        textFeild.resignFirstResponder()
        
    }
}

extension BookingVC :UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtStartdate {
            datePicker.datePickerMode = .date
        }else if textField == txtStartTime {
            datePicker.datePickerMode = .time
        }else if textField == txtEnddate {
            datePicker.datePickerMode = .date
        }else if textField == txtEndTime {
            datePicker.datePickerMode = .time
        }
    }
   
}
