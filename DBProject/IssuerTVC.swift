//
//  IssuerTVC.swift
//  DBProject
//
//  Created by Artem Misesin on 2/23/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class IssuerTVC: NSViewController, DBTable {
    
    //outlet here
    
    @IBOutlet weak var table: NSTableView!
    
    var mainRequest = "select * from issuer where approved = true";
    
    var reloadNeeded = false
    
    var dbHandler = DBEditor()
    
    var fields: [[String]]?
    
    var connection: PGConnection?
    
    var selectedRow = 0{
        willSet{
            if selectedRow != newValue{
                previousSelected = selectedRow
            }
            if let parent = self.parent as? TabBarViewController {
                parent.selectedRow = newValue
            }
        }
    }
    
    var previousSelected: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        connection = PGConnection()
        fields = fetchAllData(at: connection!)
    }
    
    override func viewWillAppear() {
        table.rowView(atRow: selectedRow, makeIfNecessary: false)?.backgroundColor = .clear
        table.deselectRow(selectedRow)
        if reloadNeeded{
            fields = fetchAllData(at: connection!)
            table.reloadData()
            reloadNeeded = false
        }
    }
}

extension IssuerTVC: NSTableViewDataSource {
    public func numberOfRows(in tableView: NSTableView) -> Int {
        if let count = fields?.count {
            return count
        }
        return 0
    }
}

extension IssuerTVC: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, rowActionsForRow row: Int, edge: NSTableRowActionEdge) -> [NSTableViewRowAction] {
        let delete = NSTableViewRowAction(style: .destructive, title: "Delete") { action, index in
            print(self.dbHandler.delete(id: self.fields![row][0], of: .brokers))
            self.fields = self.fetchAllData(at: self.connection!)
            tableView.reloadData()
        }
        let contract = NSTableViewRowAction(style: .regular, title: "Contract") { action, index in
            print("contract")
        }
        return [contract, delete]
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if let selectedIndex = table.selectedRowIndexes.first {
            table.rowView(atRow: selectedIndex, makeIfNecessary: false)?.backgroundColor = NSColor(calibratedRed: 0.96, green: 0.97, blue: 0.98, alpha: 1)
            selectedRow = selectedIndex
            if let previous = previousSelected{
                table.rowView(atRow: previous, makeIfNecessary: false)?.backgroundColor = .clear
            }
        }
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var name: String = ""
        var phone = ""
        
        guard let item = fields?[row] else {
            return nil
        }
        if tableColumn == tableView.tableColumns[0] {
            name = item[1]
            phone = item[4]
        }
        
        table.selectionHighlightStyle = .none
        
        // 3
        if let cell = tableView.make(withIdentifier: "name", owner: nil) as? CustomCell {
            cell.nameLabel.stringValue = name
            cell.phoneLabel.stringValue = phone
            cell.userPicture?.downloadedFrom(link: item[9])
            cell.wantsLayer = true
            let separator = NSView(frame: NSRect(x: cell.bounds.minX, y: cell.bounds.minY + 1, width: cell.bounds.width, height: 1))
            separator.wantsLayer = true
            separator.layer?.backgroundColor = NSColor.lightGray.cgColor
            cell.addSubview(separator)
            return cell
        }
        return nil
    }
}
