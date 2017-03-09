//
//  Presenting.swift
//  DBProject
//
//  Created by Artem Misesin on 3/9/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

protocol Presenting {
    
    var presentedObject: Tables{get set}
    
    var noneSelected:Bool{get set}
    
    var infoValues: [String]{get set}
    
    func reloadInfo(with data: [String])
    
}
