//
//  DataEnterVC.swift
//  DBProject
//
//  Created by Artem Misesin on 3/12/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class DataEnterVC: NSViewController, NSTextFieldDelegate, DBQueries {

    @IBOutlet weak var stackView: NSStackView!
    
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var secondNameField: NSTextField!
    @IBOutlet weak var iDSeriesField: NSTextField!
    @IBOutlet weak var iDField: NSTextField!
    
    @IBOutlet weak var mailField: NSTextField!
    @IBOutlet weak var passField: NSSecureTextField!
    @IBOutlet weak var rePassField: NSSecureTextField!
    
    @IBOutlet weak var nameTitle: NSTextField!
    @IBOutlet weak var secondNameTitle: NSTextField!
    @IBOutlet weak var iDSeriesTitle: NSTextField!
    @IBOutlet weak var iDNumberTitle: NSTextField!
    
    @IBOutlet weak var errorField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        errorField.sizeToFit()
        managingSubviews()
        fetchData()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if identifier == "back"{
            return true
        } else {
            var result = uniqueValidation(mail: mailField.stringValue)
            if result == "tuplesOK"{
                errorField.stringValue = "E-mail is already used"
                return false
            }
            result = uniqueValidation(id: iDField.stringValue, series: iDSeriesField.stringValue)
            if result == "tuplesOK"{
                errorField.stringValue = "ID is already used"
                return false
            }
            if !isValidEmail(testStr: mailField.stringValue) {
                errorField.stringValue = "Incorrent e-mail address."
                return false
            }
            if SingleObject.shared.type == .issuer {
                if nameField.stringValue == "" || secondNameField.stringValue == "" || mailField.stringValue == "" || passField.stringValue == "" {
                    errorField.stringValue = "Fill all the fields."
                    return false
                }
            } else {
                if nameField.stringValue == "" || secondNameField.stringValue == "" || iDSeriesField.stringValue == "" || iDField.stringValue == "" || mailField.stringValue == "" || passField.stringValue == "" {
                    errorField.stringValue = "Fill all the fields."
                    return false
                }
            }
            if passField.stringValue != rePassField.stringValue {
                errorField.stringValue = "Your passwords are not the same"
                return false
            } else if passField.stringValue.characters.count < 8{
                errorField.stringValue = "Your passwords have to be min of 8 characters"
                return false
            }
            return true
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        loadData()
    }
    
    private func fetchData(){
        nameField.stringValue = SingleObject.shared.name
        if SingleObject.shared.type == .issuer {
            secondNameField.stringValue = SingleObject.shared.country
        } else {
            secondNameField.stringValue = SingleObject.shared.secondName
        }
        iDField.stringValue = SingleObject.shared.iD
        iDSeriesField.stringValue = SingleObject.shared.iDSeries
        mailField.stringValue = SingleObject.shared.eMail
        passField.stringValue = SingleObject.shared.password
    }
    
    private func managingSubviews(){
        switch SingleObject.shared.type {
        case .issuer:
            nameTitle.stringValue = "Name"
            secondNameTitle.stringValue = "Country"
            iDField.isHidden = true
            iDSeriesField.isHidden = true
            iDSeriesTitle.isHidden = true
            iDNumberTitle.isHidden = true
        default: break
        }
    }
    
    private func loadData(){
        SingleObject.shared.name = nameField.stringValue
        if SingleObject.shared.type == .issuer {
            SingleObject.shared.country = secondNameField.stringValue
        } else {
            SingleObject.shared.secondName = secondNameField.stringValue
        }
        SingleObject.shared.iD = iDField.stringValue
        SingleObject.shared.iDSeries = iDSeriesField.stringValue
        SingleObject.shared.eMail = mailField.stringValue
        SingleObject.shared.password = passField.stringValue
    }
    
    private func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
}
