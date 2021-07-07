//
//  SystemParameter.swift
//  
//
//  Created by Renan Maganha on 07/07/21.
//

import Foundation

struct SystemParameter : Codable {
    
    var id: Int
    var formId: Int?
    var parameterKey: String
    var parameterValue: String
    
    enum CodingKeys: String, CodingKey
    {
        case id = "ID"
        case formId = "FormID"
        case parameterKey = "Parameterkey"
        case parameterValue = "ParameterValue"
    }
}

extension SystemParameter {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        formId = try? values.decode(Int.self, forKey: .formId)
        parameterKey = try values.decode(String.self, forKey: .parameterKey)
        parameterValue  = try values.decode(String.self, forKey: .parameterValue)
    }
}
