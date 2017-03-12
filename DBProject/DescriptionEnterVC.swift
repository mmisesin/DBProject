//
//  DescriptionEnterVC.swift
//  DBProject
//
//  Created by Artem Misesin on 3/12/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class DescriptionEnterVC: NSViewController {

    @IBOutlet weak var photoField: NSTextField!
    
    @IBOutlet weak var phoneField: NSTextField!
    
    @IBOutlet weak var descriptionTitle: NSTextField!
    @IBOutlet weak var descriptionField: NSTextField!
    
    @IBOutlet weak var moneyTitle: NSTextField!
    @IBOutlet weak var capitalizationField: NSTextField!

    @IBOutlet weak var stockTitle: NSTextField!
    @IBOutlet weak var stockField: NSTextField!
    
    var dbhandler = 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managingSubviews()
        fetchData()
        // Do view setup here.
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        loadData()
        
    }
    
    private func managingSubviews(){
        switch SingleObject.shared.type {
        case .client:
            descriptionField.isHidden = true
            stockField.isHidden = true
            capitalizationField.isHidden = false
            moneyTitle.stringValue = "Money Available"
            descriptionField.isHidden = true
            stockTitle.isHidden = true
        case .broker:
            descriptionField.isHidden = false
            capitalizationField.isHidden = true
            moneyTitle.isHidden = true
            stockField.isHidden = true
            stockTitle.isHidden = true
        case .issuer:
            descriptionField.isHidden = false
            capitalizationField.isHidden = false
            stockField.isHidden = false
        default: break
        }
    }
    
    private func fetchData(){
        photoField.stringValue = SingleObject.shared.photo
        phoneField.stringValue = SingleObject.shared.phoneNumber
        capitalizationField.stringValue = "\(SingleObject.shared.money)"
        switch SingleObject.shared.type{
        case .client:
            descriptionField.stringValue = ""
            stockField.stringValue = ""
        case .broker:
            descriptionField.stringValue = SingleObject.shared.description
            capitalizationField.stringValue = ""
            stockField.stringValue = ""
        case .issuer:
            descriptionField.stringValue = SingleObject.shared.description
            stockField.stringValue = "\(SingleObject.shared.stockPrice)"
        default: break
        }
    }
    
    private func loadData(){
        SingleObject.shared.photo = photoField.stringValue
        SingleObject.shared.phoneNumber = phoneField.stringValue
        SingleObject.shared.description = descriptionField.stringValue
        if let money = Double(capitalizationField.stringValue), let stockPrice = Double(stockField.stringValue){
            SingleObject.shared.money = money
            SingleObject.shared.stockPrice = stockPrice
        }
    }
}
