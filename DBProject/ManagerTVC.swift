//
//  ManagerTVC.swift
//  DBProject
//
//  Created by Artem Misesin on 2/26/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class ManagerTVC: NSViewController, DBTable {
    
    @IBOutlet weak var table: NSTableView!
    
    var mainRequest = "select * from manager";
    
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
        // Do view setup here.
        connection = PGConnection()
        fields = fetchAllData(at: connection!)
    }
    
    override func viewWillAppear() {
        table.rowView(atRow: selectedRow, makeIfNecessary: false)?.backgroundColor = .clear
        if reloadNeeded{
            fields = fetchAllData(at: connection!)
            table.reloadData()
            reloadNeeded = false
        }
        table.deselectRow(selectedRow)
    }
}

extension ManagerTVC: NSTableViewDataSource {
    public func numberOfRows(in tableView: NSTableView) -> Int {
        if let count = fields?.count {
            return count
        }
        return 0
    }
}

extension ManagerTVC: NSTableViewDelegate {
    
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
            phone = item[2]
        }
        
        table.selectionHighlightStyle = .none
        
        // 3
        if let cell = tableView.make(withIdentifier: "name", owner: nil) as? CustomCell {
            cell.nameLabel.stringValue = name
            cell.phoneLabel.stringValue = phone
            cell.userPicture?.downloadedFrom(link: item[6])
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
