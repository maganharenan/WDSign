//
//  SystemParameter.swift
//  
//
//  Created by Renan Maganha on 07/07/21.
//

import Foundation

struct SystemParameter : Codable {
    var id: Int
    var formID: Int?
    var parameterKey: String
    var parameterValue: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case formID = "FormID"
        case parameterKey = "Parameterkey"
        case parameterValue = "ParameterValue"
    }
}

extension SystemParameter {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        formID = try? values.decode(Int.self, forKey: .formID)
        parameterKey = try values.decode(String.self, forKey: .parameterKey)
        parameterValue  = try values.decode(String.self, forKey: .parameterValue)
    }
}
