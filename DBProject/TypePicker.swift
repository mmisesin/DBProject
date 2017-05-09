//
//  TypePicker.swift
//  DBProject
//
//  Created by Artem Misesin on 2/28/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class TypePicker: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let _ = segue.destination as? DataEnterVC{
            let button = sender as? NSButton
            SingleObject.shared.type = (button?.title).map { Roles(rawValue: $0) }!!
        }
    }
}
