//
//  LoggedUser.swift
//  DBProject
//
//  Created by Artem Misesin on 3/26/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Foundation

class LoggedUser{
    var type: Roles?
    var iD: String
    var username: String
    
    static let shared = LoggedUser()
    
    private init(){
        type = .admin
        iD = "(EP, 488438)"
        username = "root"
    }
}

