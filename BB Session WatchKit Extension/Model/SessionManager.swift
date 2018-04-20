//
//  SessionManager.swift
//  BB Session WatchKit Extension
//
//  Created by Jérémy Peyraud on 09/04/2018.
//  Copyright © 2018 Jeremy Peyraud. All rights reserved.
//

import Foundation

class SessionManager {
    
    private static let sessionListId = "sessionListId"
    
    public static let shared = SessionManager()
    
    private var sessionList = [Session]()
    
    private init() {
    }

    func addSession(_ session: Session) {
        sessionList.append(session)
        saveSessions()
    }
    
    func getSessionCount() -> Int {
        return sessionList.count
    }
    
    func getSessionNameList() -> [String] {
        var names = [String]()
        sessionList.forEach { names.append($0.name) }
        return names
    }
    
    func getSession(atIndex index: Int) -> Session {
        return sessionList[index]
    }
    
    func removeSession(atIndex index: Int) {
        sessionList.remove(at: index)
        saveSessions()
    }
    
    func removeExercise(atIndex exIndex: Int, fromSessionAtIndex sessIndex: Int) {
        sessionList[sessIndex].exerciseList.remove(at: exIndex)
        saveSessions()
    }
    
    func saveSessions() {
        if let encoded = try? JSONEncoder().encode(sessionList){
            UserDefaults.standard.set(encoded, forKey: SessionManager.sessionListId)
            print("Saving sessions success")
        } else {
            print("Error saving sessions")
        }
    }
    
    func loadSessions() {
        if let sessionListData = UserDefaults.standard.value(forKey: SessionManager.sessionListId) as? Data {
            if let sessionList = try? JSONDecoder().decode(Array.self, from: sessionListData) as [Session] {
                self.sessionList = sessionList
                print("Loading sessions success")
                return
            }
        }
        print("Error loading sessions")
    }
    
    func getDateFormat(_ time: Float?) -> String {
        guard let time = time else {
            return ""
        }
        let min = Int(time) / 60
        let sec = Int(time) % 60
        
        return "\(min):\(sec)"
    }
}
