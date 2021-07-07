//
//  SystemResource.swift
//  
//
//  Created by Renan Maganha on 07/07/21.
//

import Foundation

struct SystemResource: Codable {
    var id: Int
    var resourceKey: String
    var formID: Int?
    var value: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case resourceKey = "ResourceKey"
        case formID = "FormID"
        case value = "Value"
    }
}

extension SystemResource {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        formID = try? values.decode(Int.self, forKey: .formID)
        value = try values.decode(String.self, forKey: .value)
        resourceKey = try values.decode(String.self, forKey: .resourceKey)
    }
}
