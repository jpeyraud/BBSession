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
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        
        let sessionList = SessionManager.shared.getSessionNameList()
        sessionTable.setNumberOfRows(sessionList.count, withRowType: LabelTableRowController.storyboardId)
        
        for i in 0..<sessionList.count {
            let row = sessionTable.rowController(at: i) as! LabelTableRowController
            row.rowLabel.setText(sessionList[i])
        }
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let session = SessionManager.shared.getSession(atIndex: rowIndex)
        
        pushController(withName: SessionDescriptionInterfaceController.storyboardId, context: session)
    }
}
