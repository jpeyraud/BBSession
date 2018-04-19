//
//  Exercise.swift
//  BB Session WatchKit Extension
//
//  Created by Jérémy Peyraud on 09/04/2018.
//  Copyright © 2018 Jeremy Peyraud. All rights reserved.
//

import Foundation

class Exercise: Codable {
    
    let name: String
    let repetitions: Int
    let series: Int
    let restTime: Int
    var weight: Int
    
    var remainingSeries: Int
    var remainingRestTime: Float
    var isFinished: Bool
    
    init(name: String, repetitions: Int, series: Int, restTime: Int) {
        self.name = name
        self.repetitions = repetitions
        self.series = series
        self.restTime = restTime
        self.weight = 0
        self.remainingSeries = 0
        self.remainingRestTime = 0
        self.isFinished = false
    }
    
    func start() {
        remainingSeries = series
        remainingRestTime = Float(restTime)
        isFinished = false
    }
    
    func didFinishRestingShouldContinue() -> Bool {
        guard !isFinished else {
            return false
        }
        
        remainingSeries -= 1
        if remainingSeries != 0 {
            remainingRestTime = Float(restTime)
        } else {
            isFinished = true
        }
        
        return !isFinished
    }
}
