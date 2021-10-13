//
//  WDSignViewModel.swift
//  
//
//  Created by Renan Maganha on 07/07/21.
//

import SwiftUI

class WDSignViewModel: ObservableObject {
    private var documentLayoutInfo: SignDocumentLayoutInfo!
    private var customerFormRecordID: String?
    private var contactFormRecordID: String?
    private var placeholders = Array<String>()
    private var subscribers = Array<SubscriberData>()
    private var productsList = Array<String>()
    
    init(documentID: Int, customerFormRecordID: String?, productsList: Array<String>, contactFormRecordID: String?) {
        self.documentLayoutInfo = WDSignDAO.instance.fetchDocumentInformations(documentID: documentID)
        self.customerFormRecordID = customerFormRecordID
        self.contactFormRecordID = contactFormRecordID
        self.productsList = productsList
        self.placeholders = handlePlaceholders()
        self.handleSubscribers()
        
        buildPlaceholdersList()
    }
    
    public func getDocumentLayoutInfo() -> SignDocumentLayoutInfo {
        return documentLayoutInfo
    }
    
    public func getNumberOfSignatureFields() -> Int {
        return subscribers.count
    }
    
    public func getSubscriber(at index: Int) -> SubscriberData {
        return subscribers[index]
    }
    
    public func getFormatedDateToDocument() -> String {
        let date = Date()
        let year = date.toString("yyyy")
        let month = date.toString("MMMM").lowercased()
        let day = date.toString("dd")
        let of = Constants.SystemResources.of.translateResource()
        
        return "\(day) \(of) \(Constants.SystemResources.init(rawValue: month)?.translateResource() ?? "") \(of) \(year)"
    }
    
    public func buildProductsList() -> String {
        var list = "\n"
        
        for product in productsList {
            list += "\n•    \(product)"
        }
        
        return list
    }
    
    private func handlePlaceholders() -> Array<String> {
        var placeholders = Array<String>()
        
        guard let placeholder1 = documentLayoutInfo.placeholderSubscriber1, !placeholder1.isEmpty else { return [] }
        placeholders.append(placeholder1)
        
        guard let placeholder2 = documentLayoutInfo.placeholderSubscriber2, !placeholder2.isEmpty else { return placeholders }
        placeholders.append(placeholder2)
        
        guard let placeholder3 = documentLayoutInfo.placeholderSubscriber3, !placeholder3.isEmpty else { return placeholders }
        placeholders.append(placeholder3)
        
        return placeholders
    }
    
    private func handleSubscribers() {
        let factory = SubscriberFactory(customerFormRecordID: customerFormRecordID)
        
        subscribers = factory
            .createSubscribers(placeholders: placeholders, customerFormRecordID: customerFormRecordID)
            .getSubscribersList()
    }
    
    public func handleSignaturePersistence(id: String, completion: @escaping (Bool) -> Void) {
        let signLog = SignLog(id: id,
                              signDocumentID: documentLayoutInfo.id,
                              signDateTime: Date().toStringHHmmss(),
                              userID: Int(SystemParameterDAO.instance.getSystemParameter(with: Constants.SystemParameters.UserID)?.parameterValue ?? "") ?? 0,
                              secondaryUserID: nil,
                              formRecordID: handleFormRecordID(),
                              readOnly: 0)
        
        SignLogDAO.instance.persistSignatureLog(signLog: signLog) { success in
            completion(success)
        }
    }

    private func handleFormRecordID() -> String? {
        if let contactFormRecordID = contactFormRecordID, !contactFormRecordID.isEmpty {
            
            return contactFormRecordID
        }
        
        return customerFormRecordID
    }
    
    public func sendNotificationToWDSpace() {
        if documentLayoutInfo.blockChangesAfterSign == 1 {
            NotificationCenter.default.post(name: NSNotification.Name("blockChangesAfterSign"), object: nil, userInfo: ["response":true])
        }
    }
    
    public func getDocumentTextFormatedWithValues(text: String) -> String {
        let placeholdersList = buildPlaceholdersList(text: text)
        let cleanedPlaceholdersList = cleanPlaceholdersInvalidCharacters(placeholders: placeholdersList)
        let placeholdersValues = getValuesForPlaceholdes(placeholders: cleanedPlaceholdersList)
        
        var newText = documentLayoutInfo.documentText
        
        placeholdersValues.forEach { placeholder in
            newText = newText.replacingOccurrences(of: placeholder.0, with: placeholder.1)
        }
        
        return newText
    }
    
    private func buildPlaceholdersList(text: String) -> Array<String> {
        let stringComponents: Array<String> = text.components(separatedBy: " ").filter { $0.contains("{") && $0.contains("}") }
        
        return stringComponents
    }
    
    private func cleanPlaceholdersInvalidCharacters(placeholders: Array<String>) -> Array<String> {
        var cleanedPlaceholders = Array<String>()
        
        for placeholder in placeholders {
            cleanedPlaceholders.append(placeholder.slice(from: "{", to: "}") ?? "")
        }
        
        return cleanedPlaceholders
    }
    
    private func getValuesForPlaceholdes(placeholders: Array<String>) -> Array<(String, String)> {
        var response = Array<(String, String)>()
        
        placeholders.forEach { placeholder in
            response.append(("{\(placeholder)}", ""))
        }
        
        return response
    }
    
    private func getValueFor(placeholder: String) -> String {
        switch placeholder {
        case "PRODUCT_LIST": return buildProductsList()
        case "USER_ID": return SystemParameterDAO.instance.getSystemParameter(with: .UserID, formID: nil)?.parameterValue ?? ""
        case "USER_NAME": return SystemParameterDAO.instance.getSystemParameter(with: .Username, formID: nil)?.parameterValue ?? ""
        default:
            if placeholder.contains("FORM_FIELD") {
                return getFormFieldValueFor(placeholder: placeholder)
            } else {
                return ""
            }
        }
    }
    
    private func getFormFieldValueFor(placeholder: String) -> String {
        let formFieldID = placeholder.slice(from: "(", to: ")") ?? ""
        
        return FormDataDAO.instance.getFormDataValue(formRecordID: customerFormRecordID ?? "", formFieldID: formFieldID)
    }
}

extension String {

    func slice(from: String, to: String) -> String? {

        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
