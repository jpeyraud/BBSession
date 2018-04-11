//
//  SessionDescriptionInterfaceController.swift
//  BB Session WatchKit Extension
//
//  Created by Jérémy Peyraud on 11/04/2018.
//  Copyright © 2018 Jeremy Peyraud. All rights reserved.
//

import WatchKit
import Foundation

class SessionDescriptionInterfaceController: WKInterfaceController {
    
    static let storyboardId = "SessionDescriptionInterfaceController"
    
    @IBOutlet var exerciseTable: WKInterfaceTable!
    
    private var exerciseList = [Exercise]()
    
    override func awake(withContext context: Any?) {
        if let selectedSession = context as? Session {
            self.setTitle(selectedSession.name)
            
            exerciseList = selectedSession.exerciseList
            exerciseTable.setNumberOfRows(exerciseList.count, withRowType: LabelTableRowController.storyboardId)
            
            for i in 0..<exerciseList.count {
                let row = exerciseTable.rowController(at: i) as! LabelTableRowController
                row.rowLabel.setText(exerciseList[i].name)
            }
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let exercise = exerciseList[rowIndex]
        
        pushController(withName: ExerciseDescriptionInterfaceController.storyboardId, context: exercise)
    }
}
