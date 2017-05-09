//
//  DBAuth.swift
//  DBProject
//
//  Created by Artem Misesin on 3/26/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Foundation

protocol DBQueries{
    //func auth(mail: String, pass: String)
}

extension DBQueries{
    func auth(mail: String, pass: String)->String{
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
        var statement = "select * from broker where email = $1 and password = crypt($2,password)"
        var result = p.exec(statement: statement,
                            params: [mail, pass])
        switch result.numTuples(){
        case _ where result.numTuples() > 0:
            LoggedUser.shared.type = .broker
            let c1 = result.getFieldString(tupleIndex: 0, fieldIndex: 0)
            LoggedUser.shared.iD =  c1!
            return "\(result.status())"
        case 0:
            statement = "select * from client where email = $1 and password = crypt($2, password)"
            result = p.exec(statement: statement,
                            params: [mail, pass])
            switch result.numTuples(){
            case _ where result.numTuples() > 0:
                LoggedUser.shared.type = .client
                let c1 = result.getFieldString(tupleIndex: 0, fieldIndex: 0)
                LoggedUser.shared.iD =  c1!
                return "\(result.status())"
            case 0:
                statement = "select * from issuer where email = $1 and password = crypt($2, password)"
                result = p.exec(statement: statement,
                                params: [mail, pass])
                switch result.numTuples(){
                case _ where result.numTuples() > 0:
                    LoggedUser.shared.type = .issuer
                    let c1 = result.getFieldString(tupleIndex: 0, fieldIndex: 0)
                    LoggedUser.shared.iD =  c1!
                    return "\(result.status())"
                case 0:
                    statement = "select * from manager where email = $1 and password = crypt($2, password)"
                    result = p.exec(statement: statement,
                                    params: [mail, pass])
                    switch result.numTuples(){
                    case _ where result.numTuples() > 0:
                        LoggedUser.shared.type = .manager
                        let c1 = result.getFieldString(tupleIndex: 0, fieldIndex: 0)
                        LoggedUser.shared.iD =  c1!
                        return "\(result.status())"
                    case 0:
                        statement = "select * from admin where email = $1 and password = crypt($2,password)"
                        result = p.exec(statement: statement,
                                        params: [mail, pass])
                        switch result.numTuples(){
                        case _ where result.numTuples() > 0:
                            LoggedUser.shared.type = .admin
                            return "\(result.status())"
                        case 0:
                            return "No results"
                        default: break
                        }
                        fallthrough
                    default: break
                    }
                    fallthrough
                default: break
                }
                fallthrough
            default: break
            }
            fallthrough
        default:
            return result.errorMessage()
        }
    }
    
    func uniqueValidation(mail: String)->String{
        print(mail)
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
        var statement = "select * from broker where email = $1"
        var result = p.exec(statement: statement,
                            params: [mail])
        switch result.numTuples(){
        case _ where result.numTuples() > 0:
            return "\(result.status())"
        case 0:
            statement = "select * from client where email = $1"
            result = p.exec(statement: statement,
                            params: [mail])
            switch result.numTuples(){
            case _ where result.numTuples() > 0:
                return "\(result.status())"
            case 0:
                statement = "select * from issuer where email = $1"
                result = p.exec(statement: statement,
                                params: [mail])
                switch result.numTuples(){
                case _ where result.numTuples() > 0:
                    return "\(result.status())"
                case 0:
                    return "No results"
                default: break
                }
                fallthrough
            default: break
            }
            fallthrough
        default:
            return result.errorMessage()
        }
    }
    func uniqueValidation(id: String, series: String)->String{
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
        var statement = "select * from broker where (brokerId).series = $1 and (brokerId).number = $2"
        var result = p.exec(statement: statement,
                            params: [id, series])
        switch result.numTuples(){
        case _ where result.numTuples() > 0:
            return "\(result.status())"
        case 0:
            statement = "select * from client where (clientId).series = $1 and (clientId).number = $2"
            result = p.exec(statement: statement,
                            params: [id, series])
            switch result.numTuples(){
            case _ where result.numTuples() > 0:
                return "\(result.status())"
            case 0:
                statement = "select * from issuer where (issuerId).series = $1 and (issuerId).number = $2"
                result = p.exec(statement: statement,
                                params: [id, series])
                switch result.numTuples(){
                case _ where result.numTuples() > 0:
                    return "\(result.status())"
                case 0:
                    return "No results"
                default: break
                }
                fallthrough
            default: break
            }
            fallthrough
        default:
            return result.errorMessage()
        }
    }

    func uniqueValidation(phoneNumber: String)->String{
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
        var statement = "select * from broker where phoneNumber = $1"
        var result = p.exec(statement: statement,
                            params: [phoneNumber])
        switch result.numTuples(){
        case _ where result.numTuples() > 0:
            return "\(result.status())"
        case 0:
            statement = "select * from client where phoneNumber = $1"
            result = p.exec(statement: statement,
                            params: [phoneNumber])
            switch result.numTuples(){
            case _ where result.numTuples() > 0:
                return "\(result.status())"
            case 0:
                statement = "select * from issuer where phoneNumber = $1"
                result = p.exec(statement: statement,
                                params: [phoneNumber])
                switch result.numTuples(){
                case _ where result.numTuples() > 0:
                    return "\(result.status())"
                case 0:
                    return "No results"
                default: break
                }
                fallthrough
            default: break
            }
            fallthrough
        default:
            return result.errorMessage()
        }
    }

}
