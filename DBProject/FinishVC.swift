//
//  FinishVC.swift
//  DBProject
//
//  Created by Artem Misesin on 3/25/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class FinishVC: NSViewController {

    @IBOutlet weak var topLine: NSTextField!
    @IBOutlet weak var bottomLine: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch SingleObject.shared.type{
        case .client:
            topLine.stringValue = "Now you can sign in and earn money."
            bottomLine.stringValue = ""
        default: break
        }
        // Do view setup here.
    }
    
}
