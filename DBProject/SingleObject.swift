//
//  SingleObject.swift
//  DBProject
//
//  Created by Artem Misesin on 3/12/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class SingleObject {
    
    var type: Roles
    
    var name: String
    
    var iD: String
    
    var phoneNumber: String
    
    var eMail: String
    
    var password: String
    
    var money: Double
    
    var stockPrice: Double
    
    var photo: String
    
    var description: String
    
    static let shared = SingleObject()
    
//    private init(name: String, iD: String, number: String, mail: String, password: String, money: Double, photo: String) {
//        self.name = name
//        self.iD = iD
//        phoneNumber = number
//        eMail = mail
//        self.password = password
//        self.money = money
//        self.photo = photo
//    }
    
    private init(){
        type = .client
        name = ""
        iD = ""
        phoneNumber = ""
        eMail = ""
        password = ""
        money = 0
        stockPrice = 0
        photo = ""
        description = ""
    }
    
}
