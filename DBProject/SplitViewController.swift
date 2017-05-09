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
    case waitingBrokers = "Waiting Brokers"
    case waitingIssuers = "Waiting Issuers"
    case none = ""
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
    var loginVC: LoginVC?
    var waitingBrokers: WaitingBrokerTVC?
    var waitingIssuers: WaitingIssuerTVC?
    
    var allowed = false
    
    var segue: ReplaceWindowContentSegue?
    
    var selectedRow = 0{
        didSet{
            if var infoView = self.childViewControllers[1] as? Presenting{
                infoView.noneSelected = false
                infoView.presentedObject = activeTab
                updateInfo()
            }
        }
    }
    
    var activeTab = Tables.none{
        didSet{
            if var infoView = self.childViewControllers[1] as? Presenting, allowed{
                updateView()
                infoView.noneSelected = true
                infoView.presentedObject = activeTab
            } else {
                print("what")
                allowed = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabVC = self.childViewControllers[0] as! NSTabViewController
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        contractInfo = storyboard.instantiateController(withIdentifier: "contractInfoVC") as? ContractInfoVC
        infoVC = self.childViewControllers[1] as? InfoVC
        print(infoVC)
        switch LoggedUser.shared.type!{
        case .client:
            activeTab = Tables.brokers
            brokerTVC = (tabVC.childViewControllers[0] as! BrokerTVC)
            cContractTVC = (tabVC.childViewControllers[1] as! CBContractTVC)
        case .broker:
            activeTab = Tables.issuers
            issuerTVC = (tabVC.childViewControllers[0] as! IssuerTVC)
            cContractTVC = (tabVC.childViewControllers[1] as! CBContractTVC)
            iContractTVC = (tabVC.childViewControllers[2] as! BIContractTVC)
        case .issuer:
            activeTab = Tables.issuerContracts
            iContractTVC = (tabVC.childViewControllers[0] as! BIContractTVC)
        case .manager:
            activeTab = Tables.clients
            clientTVC = (tabVC.childViewControllers[0] as! ClientTVC)
            brokerTVC = (tabVC.childViewControllers[1] as! BrokerTVC)
            issuerTVC = (tabVC.childViewControllers[2] as! IssuerTVC)
            cContractTVC = (tabVC.childViewControllers[3] as! CBContractTVC)
            iContractTVC = (tabVC.childViewControllers[4] as! BIContractTVC)
            waitingBrokers = (tabVC.childViewControllers[5] as! WaitingBrokerTVC)
            waitingIssuers = (tabVC.childViewControllers[6] as! WaitingIssuerTVC)
        case .admin:
            activeTab = Tables.clients
            clientTVC = (tabVC.childViewControllers[0] as! ClientTVC)
            brokerTVC = (tabVC.childViewControllers[1] as! BrokerTVC)
            issuerTVC = (tabVC.childViewControllers[2] as! IssuerTVC)
            managerTVC = (tabVC.childViewControllers[3] as! ManagerTVC)
            cContractTVC = (tabVC.childViewControllers[4] as! CBContractTVC)
            iContractTVC = (tabVC.childViewControllers[5] as! BIContractTVC)
            waitingBrokers = (tabVC.childViewControllers[6] as! WaitingBrokerTVC)
            waitingIssuers = (tabVC.childViewControllers[7] as! WaitingIssuerTVC)
        }
        clientTVC = (tabVC.childViewControllers[0] as? ClientTVC)
        
        loginVC = storyboard.instantiateController(withIdentifier: "sourceViewController") as? LoginVC
    }
    
    @IBAction func logOff(sender: AnyObject){
        LoggedUser.shared.type = .admin
        LoggedUser.shared.iD = ""
        presentViewControllerAsModalWindow(loginVC!)
        self.view.window?.close()
    }
    
    func updateInfo() {
        switch activeTab{
            case .clients:
                infoVC!.infoValues = (clientTVC!.fields![selectedRow])
            case .brokers:
                infoVC!.infoValues = (brokerTVC!.fields![selectedRow])
            case .issuers:
                infoVC?.infoValues = (issuerTVC?.fields?[selectedRow])!
            case .managers:
                infoVC?.infoValues = (managerTVC?.fields?[selectedRow])!
            case .clientContracts:
                contractInfo?.infoValues = (cContractTVC?.fields?[selectedRow])!
            case .issuerContracts:
                contractInfo?.infoValues = (iContractTVC?.fields?[selectedRow])!
            case .waitingBrokers:
                infoVC?.infoValues = (waitingBrokers?.fields?[selectedRow])!
        case .waitingIssuers:
            infoVC?.infoValues = (waitingIssuers?.fields?[selectedRow])!
        default: break
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    private func updateView() {
        let item = NSSplitViewItem(viewController: infoVC!)
        let cItem = NSSplitViewItem(viewController: contractInfo!)
        switch activeTab{
        case .clients, .brokers, .issuers, .managers, .waitingBrokers, .waitingIssuers:
            self.removeChildViewController(at: 1)
            self.addSplitViewItem(item)
        case .clientContracts, .issuerContracts:
            self.removeChildViewController(at: 1)
            self.addSplitViewItem(cItem)
        default: break
        }
    }
}
