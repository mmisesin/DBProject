//
//  DBObject.swift
//  DBProject
//
//  Created by Artem Misesin on 2/22/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Foundation

protocol DBTable {
    
    var mainRequest: String {get}
    
    var fields: [[String]]? {get set}
    
    var selectedRow: Int {get set}
    
    var previousSelected: Int? {get set}

}

extension DBTable {
    
    func fetchAllData(at connection: PGConnection) -> [[String]]{
        let p = connection
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

        let statement = mainRequest
        let result = p.exec(statement: statement)
        let numFields = result.numFields()
        let numTuples = result.numTuples()
        var returnValue: [[String]] = []
        
        for x in 0..<numTuples {
            returnValue.append([])
            for y in 0..<numFields {
                if let value = result.getFieldString(tupleIndex: x, fieldIndex: y){
                    returnValue[x].append(suitableData(from: value))
                }
            }
        }
        result.clear()
        return returnValue
    }
    
    func fetchContractsInfo(at connection: PGConnection) -> [[String]]{
        let p = connection
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
        let result = p.exec(statement: mainRequest)
        let numFields = result.numFields()
        let numTuples = result.numTuples()
        var returnValue: [[String]] = []
        
        for x in 0..<numTuples {
            returnValue.append([])
            for y in 0..<numFields {
                if let value = result.getFieldString(tupleIndex: x, fieldIndex: y){
                    returnValue[x].append(suitableData(from: value))
                }
            }
        }
        result.clear()
        return returnValue
    }
    
    func suitableData(from string: String) -> String {
        var result = string.replacingOccurrences(of: "(", with: "")
        result = result.replacingOccurrences(of: ")", with: "")
        result = result.replacingOccurrences(of: ",", with: " ")
        return result
    }
}
