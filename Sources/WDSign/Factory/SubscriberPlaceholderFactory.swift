//
//  SubscriberPlaceholderFactory.swift
//  
//
//  Created by Renan Maganha on 07/07/21.
//

import Foundation

protocol SubscriberPlaceholderFactory {
    func createSubscriber() -> SubscriberData
    func getSubscriberName() -> String
    func getSubscriberjobTitle() -> String
    func getSubscriberDocument() -> String
}

final class SubscriberFactory {
    private var customerFormRecordID: String?
    private var placeholderType: Constants.PlaceholderSubscriberType!
    private var subscribers = Array<SubscriberData>()
    
    public func getSubscribersList() -> Array<SubscriberData> {
        return subscribers
    }
    
    public func createSubscribers(placeholders: Array<String>, customerFormRecordID: String? = nil) -> Self {
        for placeholder in placeholders {
            createSubscriber(placeholder: placeholder, customerFormRecordID: customerFormRecordID)
        }
        
        return self
    }
    
    @discardableResult
    public func createSubscriber(placeholder: String, customerFormRecordID: String? = nil) -> Self {
        let placeholderType = Constants.PlaceholderSubscriberType.init(rawValue: placeholder)
        
        switch placeholderType {
        case .Form:
            guard let customerFormRecordID = customerFormRecordID else { return self }
            subscribers.append(FormPlaceholderFactory(customerFormRecordID: customerFormRecordID).createSubscriber())
        default: break
        }
        
        return self
    }
}

final class FormPlaceholderFactory: SubscriberPlaceholderFactory {
    private var customerFormRecordID: String
    
    init(customerFormRecordID: String?) {
        self.customerFormRecordID = customerFormRecordID ?? ""
    }
    
    func createSubscriber() -> SubscriberData {
        return SubscriberData(name: getSubscriberName(), jobTitle: getSubscriberjobTitle(), document: getSubscriberDocument())
    }
    
    func getSubscriberName() -> String {
        SubscriberDAO.instance.getEntityName(customerFormRecordID: customerFormRecordID)
    }
    
    func getSubscriberjobTitle() -> String {
        SubscriberDAO.instance.getEntityJobTitle(customerFormRecordID: customerFormRecordID)
    }
    
    func getSubscriberDocument() -> String {
        SubscriberDAO.instance.getEntityDocument(customerFormRecordID: customerFormRecordID)
    }
}

//User
//Manager
//Subordinate

class SubscriberData: NSObject {
    let name: String
    let jobTitle: String
    let document: String
    
    init(name: String, jobTitle: String, document: String) {
        self.name = name
        self.jobTitle = jobTitle
        self.document = document
    }
}
