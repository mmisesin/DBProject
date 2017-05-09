//
//  SingleObject.swift
//  DBProject
//
//  Created by Artem Misesin on 3/12/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

enum Roles: String {
    case client = "Client"
    case broker = "Broker"
    case issuer = "Issuer"
    case manager = "Manager"
    case admin = "Admin"
}

class SingleObject {
    
    var type: Roles
    
    var name: String
    
    var secondName: String
    
    var iD: String
    
    var iDSeries: String
    
    var phoneNumber: String
    
    var eMail: String
    
    var password: String
    
    var money: Double
    
    var stockPrice: Double
    
    var photo: String
    
    var description: String
    
    var creationDate: String
    
    var country: String
    
    static let shared = SingleObject()
    
    func fetchData() -> [Any] {
        
        var resultArray: [Any] = []
        switch type{
        case .client:
            resultArray.append(iD)
            resultArray.append(iDSeries)
            resultArray.append(name)
            resultArray.append(secondName)
            resultArray.append(phoneNumber.replacingOccurrences(of: " ", with: ""))
            resultArray.append(eMail)
            resultArray.append(password)
            resultArray.append(money)
            resultArray.append(photo)
        case .broker:
            resultArray.append(iD)
            resultArray.append(iDSeries)
            resultArray.append(name)
            resultArray.append(secondName)
            resultArray.append(phoneNumber.replacingOccurrences(of: " ", with: ""))
            resultArray.append(eMail)
            resultArray.append(password)
            resultArray.append(photo)
            resultArray.append(description)
        case .issuer:
            resultArray.append(money)
            resultArray.append(name)
            resultArray.append(stockPrice)
            resultArray.append(phoneNumber.replacingOccurrences(of: " ", with: ""))
            resultArray.append(eMail)
            resultArray.append(password)
            resultArray.append(creationDate)
            resultArray.append(country)
            resultArray.append(photo)
            resultArray.append(description)

        default: break
        }
        return resultArray
    }
    
    private init(){
        type = .client
        name = ""
        secondName = ""
        iD = ""
        iDSeries = ""
        phoneNumber = ""
        eMail = ""
        password = ""
        money = 0
        stockPrice = 0
        photo = ""
        description = ""
        creationDate = ""
        country = ""
    }
    
}
