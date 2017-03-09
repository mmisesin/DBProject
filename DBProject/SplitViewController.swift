//
//  ViewController.swift
//  DBProject
//
//  Created by Artem Misesin on 2/21/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

enum Tables: String {
    case clients = "Clients"
    case brokers = "Brokers"
    case issuers = "Issuers"
    case managers = "Managers"
    case clientContracts = "Client Contracts"
    case issuerContracts = "Issuer Contracts"
}

enum Roles: String {
    case client, broker, issuer, manager, admin
}

class SplitViewController: NSSplitViewController {
    
    var infoVC: InfoVC?
    var clientTVC: ClientTVC?
    var brokerTVC: BrokerTVC?
    var issuerTVC: IssuerTVC?
    var managerTVC: ManagerTVC?
    var cContractTVC: CBContractTVC?
    var iContractTVC: BIContractTVC?
    var contractInfo: ContractInfoVC?
    
    var segue: ReplaceWindowContentSegue?
    
    var selectedRow = 0{
        didSet{
            if var infoView = self.childViewControllers[1] as? Presenting{
                infoView.noneSelected = false
            }
            updateInfo()
        }
    }
    
    var activeTab = Tables.clients{
        didSet{
            updateView()
            if var infoView = self.childViewControllers[1] as? Presenting{
                infoView.noneSelected = true
                infoView.presentedObject = activeTab
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabVC = self.childViewControllers[0] as! NSTabViewController
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        contractInfo = storyboard.instantiateController(withIdentifier: "contractInfoVC") as? ContractInfoVC
        infoVC = self.childViewControllers[1] as? InfoVC
        clientTVC = (tabVC.childViewControllers[0] as! ClientTVC)
        brokerTVC = (tabVC.childViewControllers[1] as! BrokerTVC)
        issuerTVC = (tabVC.childViewControllers[2] as! IssuerTVC)
        managerTVC = (tabVC.childViewControllers[3] as! ManagerTVC)
        cContractTVC = (tabVC.childViewControllers[4] as! CBContractTVC)
        iContractTVC = (tabVC.childViewControllers[5] as! BIContractTVC)
    }
    
    func updateInfo() {
        switch activeTab{
            case .clients:
                infoVC?.infoValues = (clientTVC?.fields?[selectedRow])!
            case .brokers:
                infoVC?.infoValues = (brokerTVC?.fields?[selectedRow])!
            case .issuers:
                infoVC?.infoValues = (issuerTVC?.fields?[selectedRow])!
            case .managers:
                infoVC?.infoValues = (managerTVC?.fields?[selectedRow])!
            case .clientContracts:
                contractInfo?.infoValues = (cContractTVC?.fields?[selectedRow])!
            case .issuerContracts:
                contractInfo?.infoValues = (iContractTVC?.fields?[selectedRow])!
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func updateView() {
        let item = NSSplitViewItem(viewController: infoVC!)
        let cItem = NSSplitViewItem(viewController: contractInfo!)
        switch activeTab{
        case .clients, .brokers, .issuers, .managers:
            self.removeChildViewController(at: 1)
            self.addSplitViewItem(item)
        case .clientContracts, .issuerContracts:
            self.removeChildViewController(at: 1)
            self.addSplitViewItem(cItem)
        }
    }
}
