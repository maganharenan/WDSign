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
        let json = String(data: data, encoding: String.Encoding.utf8)
        
        print(json)
        } catch {
            print("encodeSignatureLog failled: \(error.localizedDescription)")
        }
    }
}
