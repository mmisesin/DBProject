//
//  SingleConnection.swift
//  DBProject
//
//  Created by Artem Misesin on 5/10/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Foundation

enum ConnectionStringFactory {
    static let connectionString = { () -> String in 
        if LoggedUser.shared.type == .admin{
            return "postgresql://localhost/encryptedDBProject"
        }
        return "postgresql://" + LoggedUser.shared.username + "@localhost/encryptedDBProject"
    }()
}

class SingleConnection {
    
    let p: PGConnection
    
    var result: PGConnection.StatusType
    
    static let shared = SingleConnection()
    
    func connect() {
        result = p.connectdb(ConnectionStringFactory.connectionString)
    }
    
    func disconnect() {
        p.finish()
    }
    
    private init(){
        p = PGConnection()
        result = p.status()
    }
}
