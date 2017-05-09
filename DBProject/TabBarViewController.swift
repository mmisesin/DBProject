//
//  TabBarViewController.swift
//  DBProject
//
//  Created by Artem Misesin on 2/23/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class TabBarViewController: NSTabViewController {

    var selectedRow = 0{
        didSet{
            if let parent = self.parent as? SplitViewController{
                parent.selectedRow = selectedRow
            }
        }
    }
    
    var activeTab = Tables.clients{
        didSet{
            if let parent = self.parent as? SplitViewController{
                parent.activeTab = activeTab
            }
        }
    }
    @IBOutlet weak var clientsTabItem: NSTabViewItem!
    @IBOutlet weak var brokersTabItem: NSTabViewItem!
    @IBOutlet weak var issuerTabItem: NSTabViewItem!
    @IBOutlet weak var managerTabItem: NSTabViewItem!
    @IBOutlet weak var clientContractsTabItem: NSTabViewItem!
    @IBOutlet weak var issuerContractsTabItem: NSTabViewItem!
    @IBOutlet weak var waitingIssuersTabItem: NSTabViewItem!
    @IBOutlet weak var waitingBrokersTabItem: NSTabViewItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabView.delegate = self
        switch LoggedUser.shared.type!{
        case .client:
            self.removeTabViewItem(clientsTabItem)
            self.removeTabViewItem(issuerTabItem)
            self.removeTabViewItem(managerTabItem)
            self.removeTabViewItem(issuerContractsTabItem)
            self.removeTabViewItem(waitingBrokersTabItem)
            self.removeTabViewItem(waitingIssuersTabItem)
        case .broker:
            self.removeTabViewItem(brokersTabItem)
            self.removeTabViewItem(clientsTabItem)
            self.removeTabViewItem(managerTabItem)
            self.removeTabViewItem(waitingBrokersTabItem)
            self.removeTabViewItem(waitingIssuersTabItem)
        case .issuer:
            self.removeTabViewItem(brokersTabItem)
            self.removeTabViewItem(clientsTabItem)
            self.removeTabViewItem(managerTabItem)
            self.removeTabViewItem(clientContractsTabItem)
            self.removeTabViewItem(waitingBrokersTabItem)
            self.removeTabViewItem(waitingIssuersTabItem)
        case .manager:
            self.removeTabViewItem(managerTabItem)
        default: break
        }
        // Do view setup here.
    }
    
    override func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?){
        activeTab = Tables(rawValue: (tabViewItem?.viewController?.title)!)!
        print(self.childViewControllers)
    }
    
}
