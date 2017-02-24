//
//  DBObject.swift
//  DBProject
//
//  Created by Artem Misesin on 2/22/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Foundation

protocol DBTable {
    
    var tableName: String {get set}
    
    var fields: [[String]]? {get set}
    
    var selectedRow: Int {get set}

}

extension DBTable {
    
    func fetchAllData(at connection: PGConnection) -> [[String]]{
        let p = connection
        let status = p.connectdb("host=localhost dbname=investProject")
        print(status)
        let statement = "select * from " + tableName
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
    
    func suitableData(from string: String) -> String {
        var result = string.replacingOccurrences(of: "(", with: "")
        result = result.replacingOccurrences(of: ")", with: "")
        result = result.replacingOccurrences(of: ",", with: " ")
        return result
    }
}
