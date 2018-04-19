//
//  CreateExerciseController.swift
//  BB Session WatchKit Extension
//
//  Created by Jérémy Peyraud on 10/04/2018.
//  Copyright © 2018 Jeremy Peyraud. All rights reserved.
//

import WatchKit
import Foundation


class CreateExerciseInterfaceController: WKInterfaceController {
    
    static let storyboardId = "CreateExerciseInterfaceController"
    
    static let restTimeFactor = 15
    
    @IBOutlet var seriesPicker: WKInterfacePicker!
    @IBOutlet var repetitionsPicker: WKInterfacePicker!
    @IBOutlet var restingTimePicker: WKInterfacePicker!
    
    private var seriesVal = 0
    private var repetitionsVal = 0
    private var restTime = 0
    
    private var createSessionInterfaceController: CreateSessionInterfaceController?
    
    override func awake(withContext context: Any?) {
        if let createSessionIC = context as? CreateSessionInterfaceController {
            createSessionInterfaceController = createSessionIC
        }
        
        var pickerValues = [WKPickerItem]()
        for n in 1...20 {
            let k = WKPickerItem()
            k.title = String(n)
            pickerValues.append(k)
        }
        seriesPicker?.setItems(pickerValues)
        repetitionsPicker?.setItems(pickerValues)
        
        var restPickerValues = [WKPickerItem]()
        for n in 1...12 {
            let k = WKPickerItem()
            k.title = String(SessionManager.shared.getDateFormat(Float(n * CreateExerciseInterfaceController.restTimeFactor)))
            restPickerValues.append(k)
        }
        restingTimePicker?.setItems(restPickerValues)
    }
    
    @IBAction func addExerciseToSession() {
        presentTextInputController(withSuggestions: ["Dev Couché", "Tirage Pec", "Dev Incliné H", "Rowing", "Ecarté Haltères", "Oiseau", "Dev Epaule H", "Elev Latérale H","Tirage Epaule Barre", "Dips", "Biceps Barre", "Extens Corde", "Biceps Marteau"], allowedInputMode: WKTextInputMode.plain) { result in
            if let exerciseName = result?.first as? String {
                self.createSessionInterfaceController?.exercises.append(Exercise(name: exerciseName, repetitions: self.repetitionsVal, series: self.seriesVal, restTime: self.restTime))
                self.dismiss()
            }
        }
    }
    
    @IBAction func seriesPickerUpdated(_ value: Int) {
        seriesVal = value
    }
    
    @IBAction func repetitionsPickerUpdated(_ value: Int) {
        repetitionsVal = value
    }
    
    @IBAction func restingTimePickerUpdated(_ value: Int) {
        restTime = value * CreateExerciseInterfaceController.restTimeFactor
    }
    
}
