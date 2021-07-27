//
//  File.swift
//  
//
//  Created by Renan Maganha on 20/07/21.
//

import Foundation
import SQLite

final class SignLogDAO {
    static let instance = SignLogDAO()
    internal init() {}
    
    func persistSignatureLog(signLog: SignLog, completion: @escaping (Bool) -> Void) {
        let tableSignLog = Table("SignLog")
        
        do {
            try Database.instance.db.run(tableSignLog.insert(signLog))
            completion(true)
        } catch {
            print("persistSignatureLog failled: \(error.localizedDescription)")
            completion(false)
        }
    }
}
