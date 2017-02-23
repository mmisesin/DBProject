//
//  TableViewController.swift
//  DBProject
//
//  Created by Artem Misesin on 2/21/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class ClientTVC: NSViewController, DBTable {

    @IBOutlet weak var tableView: NSTableView!
    
    var tableName: String = "Client"
    
    var fields: [[String]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let p = PGConnection()
        fields = fetchAllData(at: p)
    }
}

extension ClientTVC: NSTableViewDataSource {
    public func numberOfRows(in tableView: NSTableView) -> Int {
        return fields!.count
    }
}

extension ClientTVC: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var image: NSImage?
        var text: String = ""
        var cellIdentifier: String = ""
        
        // 1
        guard let item = fields?[row] else {
                return nil
        }
        if tableColumn == tableView.tableColumns[0] {
            text = item[1]
            cellIdentifier = CellIdentifiers.NameCell
        } else if tableColumn == tableView.tableColumns[1] {
            text = item[0]
            cellIdentifier = CellIdentifiers.IDCell
        } else if tableColumn == tableView.tableColumns[2] {
            text = item[2]
            cellIdentifier = CellIdentifiers.PhoneCell
        } else if tableColumn == tableView.tableColumns[3]{
            text = item[3]
            cellIdentifier = CellIdentifiers.MoneyCell
        }
        
        // 2
        
        
        // 3
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            cell.imageView?.image = nil
            return cell
        }
        return nil
    }
}
