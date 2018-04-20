//
//  InterfaceController.swift
//  BB Session WatchKit Extension
//
//  Created by Jérémy Peyraud on 09/04/2018.
//  Copyright © 2018 Jeremy Peyraud. All rights reserved.
//

import WatchKit
import Foundation

class SessionSelectionInterfaceController: WKInterfaceController {
    
    static let storyboardId = "SessionSelectionInterfaceController"

    @IBOutlet var sessionTable: WKInterfaceTable!
    
    private var deleteMode: Bool = false {
        didSet {
            self.refreshTable()
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        
        SessionManager.shared.loadSessions()
        
        self.refreshTable()
    }
    
    @IBAction func changeEditMode() {
        deleteMode = !deleteMode
    }
    
    private func refreshTable() {
        let rowType = deleteMode ? DeleteLabelTableRowController.storyboardId : LabelTableRowController.storyboardId
        let sessionList = SessionManager.shared.getSessionNameList()
        sessionTable.setNumberOfRows(sessionList.count, withRowType: rowType)
        
        for i in 0..<sessionList.count {
            if let row = sessionTable.rowController(at: i) as? LabelTableRowController {
                row.rowLabel.setText(sessionList[i])
            } else if let row = sessionTable.rowController(at: i) as? DeleteLabelTableRowController {
                row.rowLabel.setText(sessionList[i])
                row.deleteCompletion = {
                    SessionManager.shared.removeSession(atIndex: i)
                    self.refreshTable()
                    
                    if SessionManager.shared.getSessionCount() == 0 {
                        self.deleteMode = false
                    }
                }
            }
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let session = SessionManager.shared.getSession(atIndex: rowIndex)
        
        pushController(withName: SessionDescriptionInterfaceController.storyboardId, context: session)
    }
}
