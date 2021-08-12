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
    private var placeholders = Array<String>()
    private var subscribers = Array<SubscriberData>()
    private var productsList = Array<String>()
    
    init(documentID: Int, customerFormRecordID: String?, productsList: Array<String>) {
        self.documentLayoutInfo = WDSignDAO.instance.fetchDocumentInformations(documentID: documentID)
        self.customerFormRecordID = customerFormRecordID
        self.productsList = productsList
        self.placeholders = handlePlaceholders()
        self.handleSubscribers()
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
    
    public func buildProductsList() -> String {
        var list = ""
        
        for product in productsList {
            list += "\n• \(product)"
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
                              formRecordID: customerFormRecordID,
                              readOnly: 0)
        
        SignLogDAO.instance.encodeSignatureLog(signLog: signLog) { success in
            completion(success)
        }
    }
    
    public func sendNotificationToWDSpace() {
        if documentLayoutInfo.blockChangesAfterSign == 1 {
            NotificationCenter.default.post(name: NSNotification.Name("blockChangesAfterSign"), object: nil)
        }
    }
}
