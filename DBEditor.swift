//
//  DBEditor.swift
//  DBProject
//
//  Created by Artem Misesin on 3/12/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Foundation



class DBEditor{
    
    func insert() -> String{
        let p = PGConnection()
        let file = "connectionString" //this is the file. we will write to and read from it
        var connectionString = ""
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file)
            //reading
            do {
                connectionString = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {print("Error reading file")}
        }
        _ = p.connectdb(connectionString)
        var statement = ""
        switch SingleObject.shared.type{
        case .client:
            statement = "select insertClient($1, $2, $3, $4, $5, $6, $7, $8, $9)"
        case .broker:
            statement = "select insertBroker($1, $2, $3, $4, $5, $6, $7, $8, $9)"
        case .issuer:
            statement = "select insertIssuer($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)"
        default: break
        }
        let result = p.exec(statement: statement,
                            params: SingleObject.shared.fetchData())
        p.finish()
        print(result.errorMessage())
        return "\(result.status())"
    }
    
    func approve(id: String, of user: Tables) -> String{
        let p = PGConnection()
        let file = "connectionString" //this is the file. we will write to and read from it
        var connectionString = ""
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file)
            //reading
            do {
                connectionString = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {print("Error reading file")}
        }
        _ = p.connectdb(connectionString)
        var statement = ""
        var array = id.components(separatedBy: " ")
        var result: PGResult? = nil
        switch user{
        case .waitingBrokers:
            statement = "select approveBroker($1, $2)"
            result = p.exec(statement: statement,
                                params: array)
        case .waitingIssuers:
            statement = "select approveIssuer($1)"
            result = p.exec(statement: statement,
                                params: [Int(array[0])])
        default: break
        }
        print(array)
        p.finish()
        return "\(result!.errorMessage())"
    }
    
    func hold(id: String, of user: Tables) -> String{
        let p = PGConnection()
        let file = "connectionString" //this is the file. we will write to and read from it
        var connectionString = ""
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file)
            //reading
            do {
                connectionString = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {print("Error reading file")}
        }
        _ = p.connectdb(connectionString)
        var statement = ""
        var array: [Any] = id.components(separatedBy: " ")
        switch user{
        case .brokers:
            statement = "select holdBroker($1, $2)"
        case .issuers:
            array[0] = Int(array[0] as! String) ?? 0
            statement = "select holdIssuer($1, $2)"
        case .waitingIssuers:
            array[0] = Int(array[0] as! String) ?? 0
            statement = "select holdIssuer($1)"
        default: break
        }
        print(array)
        let result = p.exec(statement: statement,
                            params: array)
        p.finish()
        return "\(result.errorMessage())"
    }
    
    func delete(id: String, of user: Tables)-> String{
        let p = PGConnection()
        let file = "connectionString" //this is the file. we will write to and read from it
        var connectionString = ""
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file)
            //reading
            do {
                connectionString = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {print("Error reading file")}
        }
        _ = p.connectdb(connectionString)
        var statement = ""
        var array: [Any] = id.components(separatedBy: " ")
        switch user{
        case .waitingBrokers:
            statement = "DELETE FROM Broker WHERE (brokerID).series = $1 AND (brokerID).number = $2"
        case .waitingIssuers:
            statement = "DELETE FROM Issuer WHERE issuerID = $1"
            array[0] = Int(array[0] as! String) ?? 0
        case .clients:
            statement = "DELETE FROM Client WHERE (clientID).series = $1 AND (clientID).number = $2"
        case .brokers:
            statement = "DELETE FROM Broker WHERE (brokerID).series = $1 AND (brokerID).number = $2"
        case .issuers:
            statement = "DELETE FROM Issuer WHERE issuerID = $1"
            array[0] = Int(array[0] as! String) ?? 0
        default: break
        }
        let result = p.exec(statement: statement,
                            params: array)
        p.finish()
        return "\(result.errorMessage())"
    }
}
