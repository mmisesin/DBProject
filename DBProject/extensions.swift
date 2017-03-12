//
//  extensions.swift
//  DBProject
//
//  Created by Artem Misesin on 3/9/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Foundation
import Cocoa

extension NSLayoutConstraint {
    
    override open var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}

extension NSStoryboardSegue {
    
    var source: NSViewController? {
        return self.sourceController as? NSViewController
    }
    
    var destination: NSViewController? {
        return self.destinationController as? NSViewController
    }
}
