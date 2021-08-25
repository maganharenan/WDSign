//
//  AppSync.swift
//  
//
//  Created by Renan Maganha on 25/08/21.
//

import Foundation
import SQLite

final class AppSyncDAO {
    static let instance = AppSyncDAO()
    
    func insertRecordToSync(recordPrimaryKey: String, tableName: String) {
        let dateTime = Date().toString("yyyy-MM-dd HH:mm")
        let query = "INSERT INTO AppSync (TableName, RecordPrimaryKey, UpdateDateTime) VALUES ( '\(tableName)', '\(recordPrimaryKey)', '\(dateTime)' )"
        
        do {
            try Database.instance.db.run(query)
        } catch {
            print("insertRecordToSync failled: \(error.localizedDescription)")
        }
    }
}
