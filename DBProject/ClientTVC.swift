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
    
    var selectedRow = 0{
        willSet{
            if let parent = self.parent as? TabBarViewController {
                parent.selectedRow = newValue
            }
        }
    }
    
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
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        selectedRow = tableView.selectedRowIndexes.first!
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var image: NSImage?
        var text: String = ""
        var phone = ""
        var cellIdentifier: String = ""
        
        // 1
        guard let item = fields?[row] else {
                return nil
        }
        if tableColumn == tableView.tableColumns[0] {
            text = item[1]
            phone = item[2]
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
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? CustomCell {
            cell.nameLabel.stringValue = text
            cell.phoneLabel.stringValue = phone
            return cell
        }
        return nil
    }
}
