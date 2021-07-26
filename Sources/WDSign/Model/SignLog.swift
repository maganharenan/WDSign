//
//  SignLog.swift
//  
//
//  Created by Renan Maganha on 20/07/21.
//

import Foundation

struct SignLog: Hashable, Codable {
    let id: String
    let signDocument: Int
    let signDateTime: String
    let userID: Int
    let secondaryUserID: Int?
    let formRecordID: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case signDocument = "SignDocument"
        case signDateTime = "SignDateTime"
        case userID = "UserID"
        case secondaryUserID = "SecondaryUserID"
        case formRecordID = "FormRecordID"
    }
}
