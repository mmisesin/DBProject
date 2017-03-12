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
        willSet{
            if let parent = self.parent as? SplitViewController{
                parent.selectedRow = newValue
            }
        }
    }
    
    var activeTab = Tables.clients{
        willSet{
            if let parent = self.parent as? SplitViewController{
                parent.activeTab = newValue
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabView.delegate = self
        // Do view setup here.
    }
    
    override func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?){
        activeTab = Tables(rawValue: (tabViewItem?.viewController?.title)!)!
    }
    
}
