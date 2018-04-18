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
    var weight: Int
    
    init(name: String, repetitions: Int, series: Int) {
        self.name = name
        self.repetitions = repetitions
        self.series = series
        self.weight = 0
    }
}
