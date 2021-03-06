//
//  DeleteLabelTableRowController.swift
//  BB Session WatchKit Extension
//
//  Created by Jérémy Peyraud on 18/04/2018.
//  Copyright © 2018 Jeremy Peyraud. All rights reserved.
//

import WatchKit
import Foundation

typealias DeleteCompletion = () -> ()

class DeleteLabelTableRowController: NSObject {
    
    static let storyboardId = "DeleteLabelTableRowController"

    var deleteCompletion: DeleteCompletion?
    
    @IBOutlet var rowLabel: WKInterfaceLabel!
    
    @IBAction func deleteRow() {
        deleteCompletion?()
    }
    
}
