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
    
    @IBOutlet var seriesPicker: WKInterfacePicker!
    @IBOutlet var repetitionsPicker: WKInterfacePicker!
    
    private var seriesVal = 0
    private var repetitionsVal = 0
    
    private var createSessionInterfaceController: CreateSessionInterfaceController?
    
    override func awake(withContext context: Any?) {
        if let createSessionIC = context as? CreateSessionInterfaceController {
            createSessionInterfaceController = createSessionIC
        }
        
        var pickerValues = [WKPickerItem]()
        for n in 0...20 {
            let k = WKPickerItem()
            k.title = String(n)
            pickerValues.append(k)
        }
        seriesPicker?.setItems(pickerValues)
        repetitionsPicker?.setItems(pickerValues)
    }
    
    @IBAction func addExerciseToSession() {
        presentTextInputController(withSuggestions: ["Dev Couché","Dev Incliné","Rowing","Tirage Vertical"], allowedInputMode: WKTextInputMode.plain) { result in
            if let exerciseName = result?.first as? String {
                self.createSessionInterfaceController?.exercises.append(Exercise(name: exerciseName, repetitions: self.repetitionsVal, series: self.seriesVal))
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
    
}
