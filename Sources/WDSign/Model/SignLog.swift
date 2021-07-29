//
//  SignLog.swift
//  
//
//  Created by Renan Maganha on 20/07/21.
//

import Foundation

struct SignLog: Hashable, Codable {
    var id: String
    var signDocumentID: Int
    var signDateTime: String
    var userID: Int
    var secondaryUserID: Int?
    var formRecordID: String?
    var readOnly: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case signDocumentID = "SignDocumentID"
        case signDateTime = "SignDateTime"
        case userID = "UserID"
        case secondaryUserID = "SecondaryUserID"
        case formRecordID = "FormRecordID"
        case readOnly = "ReadOnly"
    }
}

extension SignLog {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        signDocumentID = try values.decode(Int.self, forKey: .signDocumentID)
        signDateTime = try values.decode(String.self, forKey: .signDateTime)
        userID = try values.decode(Int.self, forKey: .userID)
        secondaryUserID = try? values.decode(Int.self, forKey: .secondaryUserID)
        formRecordID = try? values.decode(String.self, forKey: .formRecordID)
        readOnly = try values.decode(Int.self, forKey: .readOnly)
    }
}
