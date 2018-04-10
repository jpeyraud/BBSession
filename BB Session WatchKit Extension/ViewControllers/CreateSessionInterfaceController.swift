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
    
    @IBOutlet var exerciseList: WKInterfaceTable!
    
    var exercises = [Exercise]()
    
    override func willActivate() {
        
        var names = [String]()
        exercises.forEach{ names.append($0.name) }
        exerciseList.setNumberOfRows(names.count, withRowType: LabelTableRowController.storyboardId)
        
        let rowCount = self.exerciseList.numberOfRows
        
        for i in 0..<rowCount {
            if let row = exerciseList.rowController(at: i) as? LabelTableRowController {
                row.rowLabel.setText(names[i])
            }
        }
    }
    
    @IBAction func addSessionToManager() {
        presentTextInputController(withSuggestions: ["Pec","Abdo","Shoulders","Back"], allowedInputMode: WKTextInputMode.plain) { result in
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
