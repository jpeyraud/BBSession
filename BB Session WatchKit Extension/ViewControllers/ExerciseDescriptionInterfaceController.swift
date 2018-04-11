//
//  SessionDescriptionInterfaceController.swift
//  BB Session WatchKit Extension
//
//  Created by Jérémy Peyraud on 11/04/2018.
//  Copyright © 2018 Jeremy Peyraud. All rights reserved.
//

import WatchKit
import Foundation

class ExerciseDescriptionInterfaceController: WKInterfaceController {
    
    static let storyboardId = "ExerciseDescriptionInterfaceController"
    
    @IBOutlet var seriesLabel: WKInterfaceLabel!
    
    @IBOutlet var repetitionsLabel: WKInterfaceLabel!
    
    @IBOutlet var weightPicker: WKInterfacePicker!
    
    private var selectedExercise: Exercise?
    
    override func awake(withContext context: Any?) {
        if let selectedExercise = context as? Exercise {
            self.setTitle(selectedExercise.name)
            
            self.selectedExercise = selectedExercise
            
            seriesLabel.setText("\(selectedExercise.repetitions)")
            repetitionsLabel.setText("\(selectedExercise.series)")
            
            var pickerValues = [WKPickerItem]()
            for n in 0...60 {
                let k = WKPickerItem()
                k.title = String(Double(n)*2.5)
                pickerValues.append(k)
            }
            weightPicker?.setItems(pickerValues)
            
            weightPicker.setSelectedItemIndex(selectedExercise.weight)
        }
    }
    
    @IBAction func weightPickerDidUpdate(_ value: Int) {
        selectedExercise?.weight = value
    }
}
