//
//  FormDataDAO.swift
//  
//
//  Created by Renan Maganha on 13/10/21.
//

import Foundation

final class FormDataDAO {
    static let instance = FormDataDAO()
    internal init() {}
    
    public func getFormDataValue(formRecordID: String, formFieldID: String) -> String {
        let query = """
        SELECT      IFNULL(LD.Description, FD.Value) Document
        FROM        FormField FF
        JOIN        FormData FD ON FF.ID = FD.FormFieldID
        LEFT JOIN   ListData LD ON FD.Value = LD.ID
        WHERE       FormID =  ( SELECT FormID FROM FormRecord WHERE  FormRecordID = '\(formRecordID)' )
        AND         FD.FormFieldID = \(formFieldID)
        AND         FormRecordID = '\(formRecordID)'
        ORDER       BY FormFieldOrder
        """
        
        var fieldValue = ""
        
        do {
            try Database.instance.db.prepare(query).forEach { row in
                fieldValue = row[0] as! String
            }
        } catch {
            print("getFormDataValue failled: \(error.localizedDescription)")
        }
        
        return fieldValue
    }
}
