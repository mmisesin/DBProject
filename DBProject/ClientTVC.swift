//
//  TableViewController.swift
//  DBProject
//
//  Created by Artem Misesin on 2/21/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class ClientTVC: NSViewController, DBTable {

    @IBOutlet weak var table: NSTableView!
    
    var mainRequest = "select * from client";
    
    var fields: [[String]]?
    
    var dbHandler = DBEditor()
    
    var connection: PGConnection?
    
    var reloadNeeded = false
    
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
        connection = PGConnection()
        fields = fetchAllData(at: connection!)
        self.view.wantsLayer = true
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

extension ClientTVC: NSTableViewDataSource {
    public func numberOfRows(in tableView: NSTableView) -> Int {
        return fields!.count
    }
}

extension ClientTVC: NSTableViewDelegate {
    
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
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        let rowView = NSTableRowView()
        return rowView
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text: String = ""
        var phone = ""
        
        // 1
        guard let item = fields?[row] else {
                return nil
        }
        if tableColumn == tableView.tableColumns[0] {
            text = item[1]
            phone = item[2]
        }
        
        // 2
        
        table.selectionHighlightStyle = .none
        
        // 3
        if let cell = tableView.make(withIdentifier: "name", owner: nil) as? CustomCell {
            cell.nameLabel.stringValue = text
            cell.wantsLayer = true
            cell.phoneLabel.stringValue = phone
            cell.userPicture?.downloadedFrom(link: item[6])
            let separator = NSView(frame: NSRect(x: cell.bounds.minX, y: cell.bounds.minY + 1, width: cell.bounds.width, height: 1))
            separator.wantsLayer = true
            separator.layer?.backgroundColor = NSColor.lightGray.cgColor
            cell.addSubview(separator)
            return cell
        }
        return nil
    }
}
