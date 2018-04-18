//
//  AddSessionViewController.swift
//  BB Session WatchKit Extension
//
//  Created by Jérémy Peyraud on 10/04/2018.
//  Copyright © 2018 Jeremy Peyraud. All rights reserved.
//

import WatchKit
import Foundation

class CreateSessionInterfaceController: WKInterfaceController {
    
    static let storyboardId = "CreateSessionInterfaceController"
    
    @IBOutlet var exerciseTable: WKInterfaceTable!
    
    var exercises = [Exercise]()
    
    private var deleteMode = false
    
    override func willActivate() {
        refreshTable()
    }
    
    private func refreshTable() {
        let rowType = deleteMode ? DeleteLabelTableRowController.storyboardId : LabelTableRowController.storyboardId
        var names = [String]()
        exercises.forEach{ names.append($0.name) }
        exerciseTable.setNumberOfRows(names.count, withRowType: rowType)
        
        let rowCount = self.exerciseTable.numberOfRows
        
        for i in 0..<rowCount {
            if let row = exerciseTable.rowController(at: i) as? LabelTableRowController {
                row.rowLabel.setText(names[i])
            } else if let row = exerciseTable.rowController(at: i) as? DeleteLabelTableRowController {
                row.rowLabel.setText(names[i])
            }
        }
    }
    
    @IBAction func changeEditMode() {
        deleteMode = !deleteMode
        
        refreshTable()
    }
    
    @IBAction func addSessionToManager() {
        presentTextInputController(withSuggestions: ["Pec", "Shoulders", "Biceps", "Triceps", "Back", "Abdos"], allowedInputMode: WKTextInputMode.plain) { result in
            if let sessionName = result?.first as? String {
                let session = Session(sessionName)
                session.exerciseList = self.exercises
                SessionManager.shared.addSession(session)
                SessionManager.shared.saveSessions()
                self.dismiss()
            }
        }
        
    }

    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        if segueIdentifier == "createExerciseSegue" {
            return self
        }
        
        return nil
    }
}
