//
//  DescriptionEnterVC.swift
//  DBProject
//
//  Created by Artem Misesin on 3/12/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class DescriptionEnterVC: NSViewController, DBQueries {

    @IBOutlet weak var stackView: NSStackView!
    
    @IBOutlet weak var photoField: NSTextField!
    
    @IBOutlet weak var phoneField: NSTextField!
    
    @IBOutlet weak var descriptionTitle: NSTextField!
    @IBOutlet weak var descriptionField: NSTextField!
    
    @IBOutlet weak var moneyTitle: NSTextField!
    @IBOutlet weak var capitalizationField: NSTextField!

    @IBOutlet weak var stockTitle: NSTextField!
    @IBOutlet weak var stockField: NSTextField!
    
    @IBOutlet weak var dateTitle: NSTextField!
    @IBOutlet weak var dateField: NSTextField!
    
    @IBOutlet weak var errorField: NSTextField!
    
    var dbhandler = DBEditor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managingSubviews()
        errorField.sizeToFit()
        fetchData()
        // Do view setup here.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if identifier == "back"{
            return true
        } else {
            let result = uniqueValidation(phoneNumber: phoneField.stringValue)
            if result == "tuplesOK"{
                errorField.stringValue = "Phone number is already used"
                return false
            }
            if !validate(phoneNumber: phoneField.stringValue){
                return false
            }
            loadData()
            if SingleObject.shared.type == .issuer {
                print(photoField.stringValue)
                if photoField.stringValue == "" || phoneField.stringValue == "" || capitalizationField.stringValue == "" || stockField.stringValue == "" || dateField.stringValue == "" || descriptionField.stringValue == ""{
                    errorField.stringValue = "Fill all the fields."
                    return false
                } else {
                    if dbhandler.insert() == "fatalError"{
                        print(dbhandler.insert())
                        errorField.stringValue = "Error has occured."
                        return false
                    } else {
                        return true
                    }
                }
            } else if SingleObject.shared.type == .broker {
                if photoField.stringValue == "" || phoneField.stringValue == "" || descriptionField.stringValue == ""{
                    errorField.stringValue = "Fill all the fields."
                    return false
                } else {
                    if dbhandler.insert() == "fatalError"{
                        errorField.stringValue = "Error has occured."
                        return false
                    } else {
                        return true
                    }
                }
            } else {
                if photoField.stringValue == "" || phoneField.stringValue == "" || capitalizationField.stringValue == ""{
                    errorField.stringValue = "Fill all the fields."
                    return false
                } else {
                    if dbhandler.insert() == "fatalError"{
                        errorField.stringValue = "Error has occured."
                        return false
                    } else {
                        return true
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        loadData()
    }
    
    private func managingSubviews(){
        switch SingleObject.shared.type {
        case .client:
            descriptionField.isHidden = true
            stockField.isHidden = true
            moneyTitle.stringValue = "Money Available"
            stockTitle.isHidden = true
            dateTitle.isHidden = true
            dateField.isHidden = true
        case .broker:
            capitalizationField.isHidden = true
            moneyTitle.isHidden = true
            stockField.isHidden = true
            stockTitle.isHidden = true
            dateTitle.isHidden = true
            dateField.isHidden = true
        default: break
        }
    }
    
    private func fetchData(){
        photoField.stringValue = SingleObject.shared.photo
        phoneField.stringValue = SingleObject.shared.phoneNumber
        capitalizationField.stringValue = "\(SingleObject.shared.money)"
        switch SingleObject.shared.type{
        case .client:
            descriptionTitle.isHidden = true
            descriptionField.isHidden = true
            stockField.isHidden = true
        case .broker:
            descriptionField.stringValue = SingleObject.shared.description
            capitalizationField.isHidden = true
            stockField.isHidden = true
        case .issuer:
            descriptionField.stringValue = SingleObject.shared.description
            dateField.stringValue = SingleObject.shared.creationDate
            stockField.stringValue = "\(SingleObject.shared.stockPrice)"
        default: break
        }
    }
    
    private func loadData(){
        SingleObject.shared.photo = photoField.stringValue
        SingleObject.shared.phoneNumber = phoneField.stringValue
        SingleObject.shared.description = descriptionField.stringValue
        SingleObject.shared.creationDate = dateField.stringValue
        if let money = Double(capitalizationField.stringValue){
            SingleObject.shared.money = money
        }
        if let stockPrice = Double(stockField.stringValue){
            SingleObject.shared.stockPrice = stockPrice
        }
    }
    
    private func validate(phoneNumber: String) -> Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = phoneNumber.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  phoneNumber == filtered
    }

}
