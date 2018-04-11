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
    
    override func willActivate() {
        
        var names = [String]()
        exercises.forEach{ names.append($0.name) }
        exerciseTable.setNumberOfRows(names.count, withRowType: LabelTableRowController.storyboardId)
        
        let rowCount = self.exerciseTable.numberOfRows
        
        for i in 0..<rowCount {
            if let row = exerciseTable.rowController(at: i) as? LabelTableRowController {
                row.rowLabel.setText(names[i])
            }
        }
    }
    
    @IBAction func addSessionToManager() {
        presentTextInputController(withSuggestions: ["Pec","Biceps","Triceps","Shoulders","Back", "Abdos"], allowedInputMode: WKTextInputMode.plain) { result in
            if let sessionName = result?.first as? String {
                let session = Session(sessionName)
                session.exerciseList = self.exercises
                SessionManager.shared.addSession(session)
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
