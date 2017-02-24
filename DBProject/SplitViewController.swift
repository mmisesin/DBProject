//
//  ViewController.swift
//  DBProject
//
//  Created by Artem Misesin on 2/21/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController {
    
    var infoVC: InfoVC?
    var clientTVC: ClientTVC?
    var brokerTVC: BrokerTVC?
    var issuerTVC: IssuerTVC?
    
    var selectedRow = 0{
        didSet{
            print("selected row changed")
            updateInfo()
        }
    }
    
    var activeTab = "Clients"{
        willSet{
            print("tab item changed")
            infoVC?.presentedObject = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabVC = self.childViewControllers[0] as! NSTabViewController
        clientTVC = (tabVC.childViewControllers[0] as! ClientTVC)
        brokerTVC = (tabVC.childViewControllers[1] as! BrokerTVC)
        issuerTVC = (tabVC.childViewControllers[2] as! IssuerTVC)
        infoVC = (self.childViewControllers[1] as! InfoVC)
    }
    
    func updateInfo() {
        
        switch activeTab{
            case "Clients":
                infoVC?.infoValues = (clientTVC?.fields?[selectedRow])!
            case "Brokers":
                infoVC?.infoValues = (brokerTVC?.fields?[selectedRow])!
            case "Issuers":
                infoVC?.infoValues = (issuerTVC?.fields?[selectedRow])!
        default: break
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}
