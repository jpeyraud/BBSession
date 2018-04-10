//
//  SessionManager.swift
//  BB Session WatchKit Extension
//
//  Created by Jérémy Peyraud on 09/04/2018.
//  Copyright © 2018 Jeremy Peyraud. All rights reserved.
//

import Foundation

class SessionManager {
    
    public static let shared = SessionManager()
    private init() {}
    
    private var sessionList = [Session]()
    
    func addSession(_ session: Session) {
        sessionList.append(session)
    }
    
    func getSessionNameList() -> [String] {
        var names = [String]()
        sessionList.forEach { names.append($0.name) }
        return names
    }
}
