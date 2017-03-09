//
//  ContractInfoVC.swift
//  DBProject
//
//  Created by Artem Misesin on 3/8/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class ContractInfoVC: NSViewController, Presenting {

    @IBOutlet weak var firstLabel: NSTextField!
    @IBOutlet weak var secondLabel: NSTextField!
    @IBOutlet weak var fromImage: NSImageView!
    @IBOutlet weak var thirdLabel: NSTextField!
    @IBOutlet weak var fourthLabel: NSTextField!
    @IBOutlet weak var toImage: NSImageView!
    @IBOutlet weak var fifthLabel: NSTextField!
    @IBOutlet weak var sixthLabel: NSTextField!
    @IBOutlet weak var seventhLabel: NSTextField!
    @IBOutlet weak var eightLabel: NSTextField!
    
    var presentedObject = Tables.clients
    
    var noneSelected = true
    
    var infoValues: [String] = [] {
        willSet {
            reloadInfo(with: newValue)
        }
    }
    
    func reloadInfo(with data: [String]) {
        if noneSelected {
            fromImage.image = nil
            toImage.image = nil
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
            case .clientContracts:
                fromImage.image = NSImage(byReferencing:NSURL(string: data[9]) as! URL)
                toImage.image = NSImage(byReferencing:NSURL(string: data[8]) as! URL)
                firstLabel?.stringValue = "ID: \(data[0])"
                secondLabel?.stringValue = "$\(data[1])"
                thirdLabel?.stringValue = data[4]
                fourthLabel?.stringValue = data[5]
                fifthLabel?.stringValue = data[7]
                sixthLabel?.stringValue = data[6]
                seventhLabel?.stringValue = "ID: " + data[3]
                eightLabel?.stringValue = "ID: " + data[2]
            case .issuerContracts:
                fromImage.image = NSImage(byReferencing:NSURL(string: data[7]) as! URL)
                toImage.image = NSImage(byReferencing:NSURL(string: data[8]) as! URL)
                firstLabel?.stringValue = "ID: \(data[0])"
                secondLabel?.stringValue = "\(data[4])"
                thirdLabel?.stringValue = data[1]
                fourthLabel?.stringValue = "\(Double(data[1])! / Double(data[9])!)"
                fifthLabel?.stringValue = data[5]
                sixthLabel?.stringValue = data[6]
                seventhLabel?.stringValue = "ID: " + data[2]
                eightLabel?.stringValue = "ID: " + data[3]
            default:
                break
            }
            if fromImage == nil {
                fromImage.image = NSImage(contentsOfFile: "NSUserGuest")
            }
            if toImage == nil {
                toImage.image = NSImage(contentsOfFile: "NSUserGuest")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
