//
//  File.swift
//  
//
//  Created by Renan Maganha on 21/06/21.
//

import Foundation

struct SignDocument: Hashable {
    var status: String
    var id: Int
    var title: String
    var endDate: String?
    var expireDate: String?
    var logID: String?
    var signDateTime: String?
    var signsPerPeriod: Int?
    var periodID: String
    var cycle: String
    var placeholderSubscriber1: String
    var placeholderSubscriber2: String
    var placeholderSubscriber3: String
    
    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case id = "ID"
        case title = "Title"
        case endDate = "EndDate"
        case expiredDate = "ExpireDate"
        case logID = "LogID"
        case signDateTime = "SignDateTime"
        case signsPerPeriod = "SignsPerPeriod"
        case periodID = "PeriodID"
        case cycle = "Ciclo"
        case placeholderSubscriber1 = "PlaceholderSubscriber1"
        case placeholderSubscriber2 = "PlaceholderSubscriber2"
        case placeholderSubscriber3 = "PlaceholderSubscriber3"
    }
}
