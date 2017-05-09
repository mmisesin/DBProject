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
    @IBOutlet weak var leftTitle: NSTextField!
    @IBOutlet weak var rightTitle: NSTextField!
    
    var presentedObject = Tables.clientContracts
    
    var noneSelected = true
    
    var infoValues: [String] = [] {
        didSet{
            reloadInfo(with: infoValues)
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
            leftTitle.stringValue = ""
            rightTitle.stringValue = ""
        } else {
            switch presentedObject {
            case .clientContracts:
                fromImage.downloadedFrom(link: data[9])
                toImage.downloadedFrom(link: data[8])
                firstLabel?.stringValue = "ID: 00000\(data[0])"
                secondLabel?.stringValue = "$\(data[1])"
                thirdLabel?.stringValue = data[4]
                fourthLabel?.stringValue = data[5]
                fifthLabel?.stringValue = data[7]
                sixthLabel?.stringValue = data[6]
                seventhLabel?.stringValue = "ID: " + data[3]
                eightLabel?.stringValue = "ID: " + data[2]
                leftTitle.stringValue = "Start date"
                rightTitle.stringValue = "Finish date"
            case .issuerContracts:
                fromImage.downloadedFrom(link: data[7])
                toImage.downloadedFrom(link: data[8])
                firstLabel?.stringValue = "ID: 00000\(data[0])"
                secondLabel?.stringValue = "\(data[4])"
                thirdLabel?.stringValue = data[1]
                fourthLabel?.stringValue = "\(round(1000*(Double(data[1])! / Double(data[9])!)) / 1000)"
                fifthLabel?.stringValue = data[5]
                sixthLabel?.stringValue = data[6]
                seventhLabel?.stringValue = "ID: " + data[2]
                eightLabel?.stringValue = "ID: 00000" + data[3]
                leftTitle.stringValue = "Money"
                rightTitle.stringValue = "Amount"
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        presentedObject = (parent as! SplitViewController).activeTab
    }
    
}
