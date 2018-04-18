//
//  Session.swift
//  BB Session WatchKit Extension
//
//  Created by Jérémy Peyraud on 09/04/2018.
//  Copyright © 2018 Jeremy Peyraud. All rights reserved.
//

import Foundation

class Session: Codable {
    
    let name: String
    
    var exerciseList = [Exercise]()
    
    init(_ name: String) {
        self.name = name
    }
    
}
