//
//  SignLog.swift
//  
//
//  Created by Renan Maganha on 20/07/21.
//

import Foundation

struct SignLog: Hashable, Codable {
    var id: String
    var signDocument: Int
    var signDateTime: String
    var userID: Int
    var secondaryUserID: Int?
    var formRecordID: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case signDocument = "SignDocument"
        case signDateTime = "SignDateTime"
        case userID = "UserID"
        case secondaryUserID = "SecondaryUserID"
        case formRecordID = "FormRecordID"
    }
}

extension SignLog {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        signDocument = try values.decode(Int.self, forKey: .signDocument)
        signDateTime = try values.decode(String.self, forKey: .signDateTime)
        userID = try values.decode(Int.self, forKey: .userID)
        secondaryUserID = try? values.decode(Int.self, forKey: .secondaryUserID)
        formRecordID = try? values.decode(String.self, forKey: .formRecordID)
    }
}
