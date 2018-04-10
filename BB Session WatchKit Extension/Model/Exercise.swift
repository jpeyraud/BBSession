//
//  Exercise.swift
//  BB Session WatchKit Extension
//
//  Created by Jérémy Peyraud on 09/04/2018.
//  Copyright © 2018 Jeremy Peyraud. All rights reserved.
//

import Foundation

class Exercise {
    
    let name: String
    let repetitions: Int
    let series: Int
    
    var currentSeries: Int
    var currentWeight: Int
    var isDone: Bool
    
    init(name: String, repetitions: Int, series: Int) {
        self.name = name
        self.repetitions = repetitions
        self.series = series
        currentSeries = 0
        currentWeight = 0
        isDone = false
    }
    
    func didFinishSeriesShouldContinue() -> Bool {
        currentSeries+=1
        isDone = currentSeries < series
        return isDone
    }
}
