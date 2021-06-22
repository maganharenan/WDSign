//
//  File.swift
//  
//
//  Created by Renan Maganha on 21/06/21.
//

import Foundation
import SQLite

class Database {
    static let instance = Database()
    var db: Connection!
    
    public func checkIfDatabaseIsAlreadyDownloaded() -> Bool {
        let databasePath = FileManager.default.documentsDirectory().appendingPathComponent("WDSpace.db")
        print(FileManager.default.fileExists(atPath: databasePath.path))
        
        if FileManager.default.fileExists(atPath: databasePath.path) {
            return true
        }
        return false
    }
    
    fileprivate func connect() {
        let databasePath = FileManager.default.documentsDirectory().appendingPathComponent("WDSpace.db")
        print("databasePath \(databasePath.path)")
        
        if FileManager.default.fileExists(atPath: databasePath.path) == false {
            print ("Database path fail")
            return
        }
        
        do {
            db = try Connection(databasePath.absoluteString)
            
            #if DEBUG
            db.trace { print($0) }
            #endif
        } catch {
            db = nil
            print ("Unable to open database")
        }
    }
    
    init() {
        connect()
    }
    
    func updateDatabase() {
        db = nil
        connect()
    }
}

extension FileManager {
    func documentsDirectory() -> URL {
        return self.urls(for: .documentDirectory, in: .userDomainMask).last!
    }
}
