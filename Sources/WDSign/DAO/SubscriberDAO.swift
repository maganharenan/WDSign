//
//  SubscriberDAO.swift
//  
//
//  Created by Renan Maganha on 07/07/21.
//

import Foundation

final class SubscriberDAO {
    static let instance = SubscriberDAO()
    internal init() {}
    
    func getEntityName(customerFormRecordID: String) -> String {
        var entityName = ""
        
        guard let formID = getEntityFormID(customerFormRecordID: customerFormRecordID) else { return entityName }
        guard let nameFormFieldID = getNameFormFieldIDFor(formID: formID) else { return entityName }

        let query = "SELECT Value FROM FormData WHERE FormRecordID = \'\(customerFormRecordID)\' AND FormFieldID = \(nameFormFieldID)"
        
        do {
            try Database.instance.db.prepare(query).forEach { row in
                if entityName.isEmpty {
                    entityName = row[0] as! String
                }
            }
        } catch {
            print("getEntityName failled: \(error.localizedDescription)")
        }
        
        return entityName
    }
    
    func getEntityJobTitle(customerFormRecordID: String) -> String {
        var jobTitle = ""

        let query = """
        SELECT  IFNULL(LD.Description, FD.Value)
        FROM            FormData FD
        LEFT JOIN   ListData LD ON FD.Value = LD.ID
        WHERE  FormFieldID IN (
            SELECT      ParameterValue
            FROM        SystemParameter
            WHERE       ParameterKey = 'sign_subtitle'
            AND         FormID = (
                SELECT FormID
                FROM FormRecord
                WHERE ID = '\(customerFormRecordID)'
            )
        )
        AND   FD.FormRecordID = '\(customerFormRecordID)'
        """
        
        do {
            try Database.instance.db.prepare(query).forEach { row in
                jobTitle = row[0] as! String
            }
        } catch {
            print("getEntityJobTitle failled: \(error.localizedDescription)")
        }
        
        return jobTitle
    }
    
    func getEntityDocument(customerFormRecordID: String) -> String {
        var entityDocument = ""
        
        guard let formID = getEntityFormID(customerFormRecordID: customerFormRecordID) else { return entityDocument }
        
        let query = """
        SELECT      IFNULL(LD.Description, FD.Value) Document
        FROM        FormField FF
        JOIN        FormData FD ON FF.ID = FD.FormFieldID
        LEFT JOIN   ListData LD ON FD.Value = LD.ID
        WHERE       FormID = \(formID)
        AND         PrimaryKey = 1
        AND         FormRecordID = \'\(customerFormRecordID)\'
        ORDER       BY FormFieldOrder
        """
        
        do {
            try Database.instance.db.prepare(query).forEach{ row in
                let rowValue = row[0] as! String
                entityDocument += entityDocument.isEmpty ? rowValue : " - \(rowValue)"
            }
        } catch {
            print("getEntityDocument failled: \(error.localizedDescription)")
        }
        
        return entityDocument
    }
    
    //MARK: - Internal methods
    
    private func getEntityFormID(customerFormRecordID: String) -> Int? {
        let query = "SELECT FormID FROM FormRecord WHERE ID = \'\(customerFormRecordID)\'"
        
        var formID: Int?
        
        do {
            try Database.instance.db.prepare(query).forEach { row in
                if formID == nil {
                    formID = Int(row[0] as! Int64)
                }
            }
        } catch {
            print("getEntityFormID failled: \(error.localizedDescription)")
        }
        
        return formID
    }
    
    private func getNameFormFieldIDFor(formID: Int) -> Int? {
        let query = """
        SELECT  TitleFormFieldID ID
        FROM        Form
        WHERE       Enabled = 1
        AND         ID IN (
            SELECT  FormID
            FROM        SystemParameter
            WHERE       ParameterKey = 'relationship_form'
            AND         ParameterValue = \(formID)
            UNION
            SELECT  \(formID)
        )
        """
        
        var formFieldID: Int?
        
        do {
            try Database.instance.db.prepare(query).forEach { row in
                if formFieldID == nil {
                    formFieldID = Int(row[0] as! Int64)
                }
            }
        } catch {
            print("getNameFormFieldFor failled: \(error.localizedDescription)")
        }
        
        return formFieldID
    }
}
