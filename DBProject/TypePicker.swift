//
//  TypePicker.swift
//  DBProject
//
//  Created by Artem Misesin on 2/28/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class TypePicker: NSViewController {

    var type: String = ""
    
    @IBAction func typeButton(_ sender: NSButton) {
        type = sender.title
        createController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func createController(){
        let nextVC = NSViewController()
        switch type{
        case "Costumer":
            var title = NSTextField(labelWithString: "Signing Up")
            title.frame = CGRect(x: self.view.bounds.midX, y: 20, width: 0, height: 0)
            title.sizeToFit()
            nextVC.view.addSubview(title)
            self.presentViewControllerAsModalWindow(nextVC)
            dismissViewController(self)
//        case "Broker":
//            
//        case "Issuer":
        default: break
        }
    }
    
}
