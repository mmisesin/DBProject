//
//  InfoView.swift
//  DBProject
//
//  Created by Artem Misesin on 2/23/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class InfoVC: NSViewController, Presenting {
    
    @IBOutlet weak var mainImage: NSImageView!
    @IBOutlet weak var firstLabel: NSTextField!
    @IBOutlet weak var thirdLabel: NSTextField!
    @IBOutlet weak var secondLabel: NSTextField!
    @IBOutlet weak var fourthLabel: NSTextField!
    @IBOutlet weak var fifthLabel: NSTextField!
    @IBOutlet weak var sixthLabel: NSTextField!
    @IBOutlet weak var seventhLabel: NSTextField!
    @IBOutlet weak var eightLabel: NSTextField!
    
    var presentedObject = Tables.clients
    
    var noneSelected = true
    
    var infoValues: [String] = [] {
        didSet {
            reloadInfo(with: infoValues)
        }
    }
    
    func reloadInfo(with data: [String]){
        if noneSelected {
            mainImage.image = NSImage(contentsOfFile: "NSUserGuest")
            firstLabel.stringValue = ""
            secondLabel.stringValue = ""
            thirdLabel.stringValue = ""
            fourthLabel.stringValue = ""
            fifthLabel.stringValue = ""
            sixthLabel.stringValue = ""
            seventhLabel.stringValue = ""
            eightLabel.stringValue = ""
        } else {
            switch presentedObject {
            case .clients:
                mainImage.image = NSImage(byReferencing:NSURL(string: data[6]) as! URL)
                firstLabel?.stringValue = data[1]
                secondLabel?.stringValue = "ID: \(data[0])"
                thirdLabel?.stringValue = "Phone: \(data[2])"
                fourthLabel?.stringValue = "E-mail: \(data[3])"
                fifthLabel?.stringValue = "$" + data[5] + "\n" + "Money available"
                sixthLabel?.stringValue = ""
                seventhLabel?.stringValue = ""
                eightLabel?.stringValue = ""
            case .issuers:
                mainImage.image = NSImage(byReferencing:NSURL(string: data[9]) as! URL)
                firstLabel?.stringValue = data[1]
                secondLabel?.stringValue = "ID: \(data[0])"
                thirdLabel?.stringValue = "Phone: \(data[4])"
                fourthLabel?.stringValue = "E-mail: \(data[5])"
                sixthLabel?.stringValue = "$" + data[2] + "\n" + "Capitalization"
                fifthLabel?.stringValue = "$" + data[3] + "\n" + "Stock price"
                seventhLabel?.stringValue = data[10]
                eightLabel?.stringValue = "Created: " + data[7]
            case .brokers:
                mainImage.image = NSImage(byReferencing:NSURL(string: data[8]) as! URL)
                firstLabel?.stringValue = data[1]
                secondLabel?.stringValue = "ID: \(data[0])"
                thirdLabel?.stringValue = "Phone: \(data[2])"
                fourthLabel?.stringValue = "E-mail: \(data[3])"
                fifthLabel?.stringValue = data[5] + "\n" + "Manager ID"
                sixthLabel?.stringValue = "$" + data[6] + "\n" + "Money available"
                seventhLabel?.stringValue = data[9]
                eightLabel?.stringValue = "Started working: " + data[7]
            case .managers:
                mainImage.image = NSImage(byReferencing:NSURL(string: data[6]) as! URL)
                mainImage.image = NSImage(contentsOf: URL(string: data[6])!)
                firstLabel?.stringValue = data[1]
                secondLabel?.stringValue = "ID: \(data[0])"
                thirdLabel?.stringValue = "Phone: \(data[2])"
                fourthLabel?.stringValue = "E-mail: \(data[3])"
                fifthLabel?.stringValue = data[5] + "\n" + "Start date"
                sixthLabel?.stringValue = ""
                seventhLabel?.stringValue = ""
                eightLabel?.stringValue = ""
            default:
                break
            }
            if mainImage == nil {
                mainImage.image = NSImage(contentsOfFile: "NSUserGuest")
            }
        }
    }
}
