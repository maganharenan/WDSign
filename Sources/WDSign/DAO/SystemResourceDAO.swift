//
//  SystemResourceDAO.swift
//  
//
//  Created by Renan Maganha on 07/07/21.
//

import Foundation

protocol SystemResourceDAOProtocol {
    init()
    func getSystemResource(with key: Constants.SystemResources, formID: Int?) -> SystemResource?
}

final class SystemResourceDAO: SystemResourceDAOProtocol {
    static let instance = SystemResourceDAO()
    private var resources: Array<SystemResource>!
    
    internal init() {
        resources = fetchResources()
    }
    
    public func getSystemResource(with key: Constants.SystemResources, formID: Int? = nil) -> SystemResource? {
        if let formID = formID {
            return resources.first(where: { $0.resourceKey == key.rawValue && $0.formID == formID })
        } else {
            return resources.first(where: { $0.resourceKey == key.rawValue })
        }
    }
    
    //MARK: - Internal methods
    private func fetchResources() -> Array<SystemResource> {
        let query = "SELECT * FROM SystemResource"
        
        var resources = Array<SystemResource>()
        
        do {
            try resources = Database.instance.db.prepare(query).map { row in
                return SystemResource(id: Int(row[0] as! Int64),
                                      resourceKey: row[1] as! String,
                                      formID: row[2] as? Int,
                                      value: row[3] as! String)
            }
        } catch {
            print("FetchResources failled: \(error.localizedDescription)")
        }
        
        return resources
    }
}
