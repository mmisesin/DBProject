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
    @IBOutlet weak var firstButton: NSButton!
    @IBOutlet weak var secondButton: NSButton!
    
    var presentedObject = Tables.none
    
    var dbhandler = DBEditor()
    
    var noneSelected = true
    
    var infoValues: [String] = [] {
        willSet {
            reloadInfo(with: newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentedObject = (parent as! SplitViewController).activeTab
        firstButton.isHidden = true
        secondButton.isHidden = true
    }
    
    @IBAction func firstButtonAction(_ sender: NSButton) {
        let tabParent = self.parent?.childViewControllers[0] as! NSTabViewController
        switch presentedObject {
        case .brokers, .issuers:
            if dbhandler.hold(id: infoValues[0], of: presentedObject) == ""{
                if let table = tabParent.childViewControllers[tabParent.selectedTabViewItemIndex] as? BrokerTVC{
                    table.fields?.remove(at: table.selectedRow)
                    table.table.reloadData()
                } else if let table = tabParent.childViewControllers[tabParent.selectedTabViewItemIndex] as? IssuerTVC{
                    table.fields?.remove(at: table.selectedRow)
                    table.table.reloadData()
                    
                }
                for table in (self.parent?.childViewControllers[0].childViewControllers)!{
                    if var temp = table as? DBTable{
                        temp.reloadNeeded = true
                    }
                }
            }
        case .waitingIssuers, .waitingBrokers:
            let string = dbhandler.approve(id: infoValues[0], of: presentedObject)
            print(string)
            if string == ""{
                if let table = tabParent.childViewControllers[tabParent.selectedTabViewItemIndex] as? WaitingIssuerTVC{
                    table.fields?.remove(at: table.selectedRow)
                    table.table.reloadData()
                } else if let table = tabParent.childViewControllers[tabParent.selectedTabViewItemIndex] as? WaitingBrokerTVC{
                    table.fields?.remove(at: table.selectedRow)
                    table.table.reloadData()
                    
                }
                for table in (self.parent?.childViewControllers[0].childViewControllers)!{
                    if var temp = table as? DBTable{
                        temp.reloadNeeded = true
                    }
                }
            }
            //case .managers:
            
        default:
            break
        }
        print(infoValues[0])
    }
    
    @IBAction func secondButtonAction(_ sender: NSButton) {
        let tabParent = self.parent?.childViewControllers[0] as! NSTabViewController
        if dbhandler.delete(id: infoValues[0], of: presentedObject) == ""{
            if let table = tabParent.childViewControllers[tabParent.selectedTabViewItemIndex]  as? BrokerTVC{
                table.fields?.remove(at: table.selectedRow)
                table.table.reloadData()
            } else if let table = tabParent.childViewControllers[tabParent.selectedTabViewItemIndex]  as? IssuerTVC{
                table.fields?.remove(at: table.selectedRow)
                table.table.reloadData()
            } else if let table = tabParent.childViewControllers[tabParent.selectedTabViewItemIndex]  as? ClientTVC{
                table.fields?.remove(at: table.selectedRow)
                table.table.reloadData()
            }else if let table = tabParent.childViewControllers[tabParent.selectedTabViewItemIndex]  as? ManagerTVC{
                table.fields?.remove(at: table.selectedRow)
                table.table.reloadData()
            }else if let table = tabParent.childViewControllers[tabParent.selectedTabViewItemIndex]  as? WaitingBrokerTVC{
                table.fields?.remove(at: table.selectedRow)
                table.table.reloadData()
            }else if let table = tabParent.childViewControllers[tabParent.selectedTabViewItemIndex]  as? WaitingIssuerTVC{
                table.fields?.remove(at: table.selectedRow)
                table.table.reloadData()
            }
            for table in (self.parent?.childViewControllers[0].childViewControllers)!{
                if var temp = table as? DBTable{
                    temp.reloadNeeded = true
                }
            }
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
            firstButton.isHidden = false
            secondButton.isHidden = false
            switch presentedObject {
            case .clients:
                mainImage.downloadedFrom(link: data[6])
                firstLabel?.stringValue = data[1]
                secondLabel?.stringValue = "ID: \(data[0])"
                thirdLabel?.stringValue = "Phone: \(data[2])"
                fourthLabel?.stringValue = "E-mail: \(data[3])"
                fifthLabel?.stringValue = "$" + data[5] + "\n" + "Money available"
                sixthLabel?.stringValue = ""
                seventhLabel?.stringValue = ""
                eightLabel?.stringValue = ""
            case .issuers, .waitingIssuers:
                mainImage.downloadedFrom(link: data[9])
                firstLabel?.stringValue = data[1]
                secondLabel?.stringValue = "ID: 00000\(data[0])"
                thirdLabel?.stringValue = "Phone: \(data[4])"
                fourthLabel?.stringValue = "E-mail: \(data[5])"
                sixthLabel?.stringValue = "$" + data[2] + "\n" + "Capitalization"
                fifthLabel?.stringValue = "$" + data[3] + "\n" + "Stock price"
                seventhLabel?.stringValue = data[10]
                eightLabel?.stringValue = "Created: " + data[7]
            case .brokers, .waitingBrokers:
                mainImage.downloadedFrom(link: data[8])
                firstLabel?.stringValue = data[1]
                secondLabel?.stringValue = "ID: \(data[0])"
                thirdLabel?.stringValue = "Phone: \(data[2])"
                fourthLabel?.stringValue = "E-mail: \(data[3])"
                fifthLabel?.stringValue = data[5] + "\n" + "Manager ID"
                sixthLabel?.stringValue = "$" + data[6] + "\n" + "Money available"
                seventhLabel?.stringValue = data[9]
                eightLabel?.stringValue = "Started working: " + data[7]
            case .managers:
                mainImage.downloadedFrom(link: data[6])
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
            if presentedObject == .waitingBrokers || presentedObject == .waitingIssuers {
                firstButton.title = "Approve"
                secondButton.title = "Disapprove"
            } else if (presentedObject == .brokers || presentedObject == .issuers) && (LoggedUser.shared.type == .manager || LoggedUser.shared.type == .admin){
                firstButton.title = "Put on hold"
                secondButton.title = "Delete"
            }
        }
    }
}
