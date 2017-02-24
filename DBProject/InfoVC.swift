//
//  InfoView.swift
//  DBProject
//
//  Created by Artem Misesin on 2/23/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class InfoVC: NSViewController {
    
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var phoneLabel: NSTextField!
    @IBOutlet weak var iDLabel: NSTextField!
    @IBOutlet weak var moneyLabel: NSTextField!
    
    var presentedObject = "Clients"
    
    var infoValues: [String] = [] {
        willSet {
            iDLabel?.stringValue = "ID: \(newValue[0])"
            nameLabel?.stringValue = newValue[1]
            phoneLabel?.stringValue = "Phone: \(newValue[2])"
            switch presentedObject {
                case "Clients", "Issuers":
                    moneyLabel?.stringValue = "Money available: \(newValue[3])"
                case "Brokers":
                    moneyLabel?.stringValue = "Money available: \(newValue[4])"
            default: break
            }
            
        }
    }
    
}
