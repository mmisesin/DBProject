//
//  LoginVC.swift
//  DBProject
//
//  Created by Artem Misesin on 2/28/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

extension NSStoryboardSegue {
    
    var source: NSViewController? {
        
        return self.sourceController as? NSViewController
        
    }
    
    var destination: NSViewController? {
        
        return self.destinationController as? NSViewController
        
    }

}

class LoginVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
}
