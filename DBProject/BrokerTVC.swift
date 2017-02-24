//
//  BrokerTableViewController.swift
//  DBProject
//
//  Created by Artem Misesin on 2/22/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class BrokerTVC: NSViewController, DBTable {

    @IBOutlet weak var brokerTable: NSTableView!
    
    var tableName: String = "Broker"
    
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
        // Do view setup here.
        let p = PGConnection()
        fields = fetchAllData(at: p)
    }
}

extension BrokerTVC: NSTableViewDataSource {
    public func numberOfRows(in tableView: NSTableView) -> Int {
        if let count = fields?.count {
            return count
        }
        return 0
    }
}

extension BrokerTVC: NSTableViewDelegate {
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        selectedRow = brokerTable.selectedRowIndexes.first!
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var image: NSImage?
        var name: String = ""
        var phone = ""
        var cellIdentifier: String = ""
        
        // 1
        
        guard let item = fields?[row] else {
            return nil
        }
            if tableColumn == tableView.tableColumns[0] {
                name = item[1]
                phone = item[2]
                cellIdentifier = CellIdentifiers.NameCell
            } else if tableColumn == tableView.tableColumns[1] {
                name = item[0]
                cellIdentifier = CellIdentifiers.IDCell
            } else if tableColumn == tableView.tableColumns[2] {
                name = item[2]
                cellIdentifier = CellIdentifiers.PhoneCell
            } else if tableColumn == tableView.tableColumns[3]{
                name = item[3]
                cellIdentifier = CellIdentifiers.ManagerCell
            } else if tableColumn == tableView.tableColumns[4] {
                name = item[4]
                cellIdentifier = CellIdentifiers.MoneyCell
            } else if tableColumn == tableView.tableColumns[5] {
                name = item[5]
                cellIdentifier = CellIdentifiers.DateCell
            }
        
        // 3
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? CustomCell {
            cell.nameLabel.stringValue = name
            cell.phoneLabel.stringValue = phone
            cell.imageView?.image = nil
            return cell
        }
        return nil
    }
}
