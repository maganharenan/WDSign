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
    
    init(documentID: Int, customerFormRecordID: String?) {
        self.documentLayoutInfo = WDSignDAO.instance.fetchDocumentInformations(documentID: documentID)
        self.customerFormRecordID = customerFormRecordID
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
}
