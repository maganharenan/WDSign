//
//  File.swift
//  
//
//  Created by Renan Maganha on 21/06/21.
//

import Foundation
import SQLite

protocol WDSignDAOProtocol {
    init()
    func fetchDocumentInformations(documentID: Int) -> SignDocumentLayoutInfo?
}

final class WDSignDAO: WDSignDAOProtocol {
    static let instance = WDSignDAO()
    internal init() {}
    
    public func fetchDocumentInformations(documentID: Int) -> SignDocumentLayoutInfo? {
        let query = """
        SELECT  A.ID,
                Title,
                A.Description,
                SignDocumentText,
                PlaceholderSubscriber1,
                PlaceholderSubscriber2,
                PlaceholderSubscriber3,
                Watermark,
                Logo
        FROM    SignDocument A,
                SignDocumentSubscriber AS SDS,
                SignDocumentTemplate AS SDT
        WHERE   A.SignDocumentSubscriberID = SDS.ID
        AND     A.SignDocumentTemplateID = SDT.ID
        AND     A.ID = \(documentID)
        """
        
        var document: SignDocumentLayoutInfo?
        
        do {
            try Database.instance.db.prepare(query).forEach { row in
                document = SignDocumentLayoutInfo(id: Int(row[0] as! Int64),
                                                  title: row[1] as! String,
                                                  description: row[2] as? String,
                                                  documentText: row[3] as! String,
                                                  placeholderSubscriber1: row[4] as? String,
                                                  placeholderSubscriber2: row[5] as? String,
                                                  placeholderSubscriber3: row[6] as? String,
                                                  watermark: row[7] as! String,
                                                  logo: row[8] as! String)
            }
        } catch {
            print("fetchDocumentInformations failled: \(error.localizedDescription)")
        }
        
        return document
    }
}

struct SignDocumentLayoutInfo {
    let id: Int
    let title: String
    let description: String?
    let documentText: String
    let placeholderSubscriber1: String?
    let placeholderSubscriber2: String?
    let placeholderSubscriber3: String?
    let watermark: String
    let logo: String
}
