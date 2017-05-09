//
//  CBContractTVC.swift
//  DBProject
//
//  Created by Artem Misesin on 2/25/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class CBContractTVC: NSViewController, DBTable {

    @IBOutlet weak var table: NSTableView!
    
    var mainRequest: String = "SELECT c.id, c.money, c.brokerID, c.clientID, c.startDate, c.finishDate, b.name, i.name, b.photo, i.photo FROM ContractCB c INNER JOIN Broker b ON c.brokerID = b.brokerid INNER JOIN Client i ON c.clientID = i.clientID"
    
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
        fields = fetchContractsInfo(at: connection!)
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

extension CBContractTVC: NSTableViewDataSource {
    public func numberOfRows(in tableView: NSTableView) -> Int {
        return fields!.count
    }
}

extension CBContractTVC: NSTableViewDelegate {
    
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
        
        var text: String = ""
        var phone = ""
        
        // 1
        guard let item = fields?[row] else {
            return nil
        }
        if tableColumn == tableView.tableColumns[0] {
            text = item[6]
            phone = "Client: " + item[7]
        }

        // 3
        
        table.selectionHighlightStyle = .none
        
        if let cell = tableView.make(withIdentifier: "name", owner: nil) as? CustomCell {
            cell.nameLabel.stringValue = text
            cell.phoneLabel.stringValue = phone
            cell.wantsLayer = true
            cell.userPicture?.downloadedFrom(link: item[9])
            let separator = NSView(frame: NSRect(x: cell.bounds.minX, y: cell.bounds.minY + 1, width: cell.bounds.width, height: 1))
            separator.wantsLayer = true
            separator.layer?.backgroundColor = NSColor.lightGray.cgColor
            cell.addSubview(separator)
            return cell
        }
        return nil
    }
}

