//
//  File.swift
//  
//
//  Created by Renan Maganha on 20/07/21.
//

import Foundation
import SwiftUI
import SQLite

final class SignLogDAO {
    static let instance = SignLogDAO()
    internal init() {}
    
    func persistSignatureLog(signLog: SignLog, completion: @escaping (Bool) -> Void) {
        let tableSignLog = Table("SignLog")
        
        do {
            try Database.instance.db.run(tableSignLog.insert(signLog))
            AppSyncDAO.instance.insertRecordToSync(recordPrimaryKey: signLog.id, tableName: "SignLog")
            completion(true)
        } catch {
            print("persistSignatureLog failled: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func encodeSignatureLog(signLog: SignLog, completion: @escaping (Bool) -> Void) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(signLog)
            sendEncodedSignatureByNotification(json: data)
            completion(true)
        } catch {
            print("encodeSignatureLog failled: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func sendEncodedSignatureByNotification(json: Data) {
        NotificationCenter.default.post(name: NSNotification.Name("EncodedSignature"), object: nil, userInfo: ["json":json])
    }
}
