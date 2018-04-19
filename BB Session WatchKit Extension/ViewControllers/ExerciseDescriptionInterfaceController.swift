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
    
    @IBOutlet var startRestButton: WKInterfaceButton!
    
    private var selectedExercise: Exercise?
    
    private var timer: Timer?
    
    override func awake(withContext context: Any?) {
        if let selectedExercise = context as? Exercise {
            self.setTitle(selectedExercise.name)
            
            self.selectedExercise = selectedExercise
            
            seriesLabel.setText("\(selectedExercise.series)")
            repetitionsLabel.setText("\(selectedExercise.repetitions)")
            
            var pickerValues = [WKPickerItem]()
            for n in 1...60 {
                let k = WKPickerItem()
                k.title = String(Double(n)*2.5)
                pickerValues.append(k)
            }
            weightPicker?.setItems(pickerValues)
            
            weightPicker.setSelectedItemIndex(selectedExercise.weight)
            
            selectedExercise.start()
        }
    }
    
    @IBAction func weightPickerDidUpdate(_ value: Int) {
        selectedExercise?.weight = value
        SessionManager.shared.saveSessions()
    }
    
    @IBAction func startRest() {
        startRestButton.setTitle(SessionManager.shared.getDateFormat(selectedExercise?.remainingRestTime))
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            guard let currentExercise = self.selectedExercise else {
                timer.invalidate()
                print("No current exercise !")
                return
            }
            
            if currentExercise.remainingRestTime <= Float(0) {
                timer.invalidate()
                self.startRestButton.setTitle("Start Rest")
                if !self.selectedExercise!.didFinishRestingShouldContinue() {
                    self.pop()
                    WKInterfaceDevice.current().play(.stop)
                } else {
                    WKInterfaceDevice.current().play(.notification)
                }
                self.seriesLabel.setText("\(self.selectedExercise?.remainingSeries ?? 0)")
            } else {
                self.selectedExercise?.remainingRestTime -= 0.1
                self.startRestButton.setTitle(SessionManager.shared.getDateFormat(self.selectedExercise?.remainingRestTime))
            }
        })
    }
}
