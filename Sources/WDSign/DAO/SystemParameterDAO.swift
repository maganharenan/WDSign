//
//  SystemParameterDAO.swift
//  
//
//  Created by Renan Maganha on 07/07/21.
//

import Foundation

protocol SystemParameterDAOProtocol {
    init()
    func getSystemParameter(with key: Constants.SystemParameters, formID: Int?) -> SystemParameter?
}

final class SystemParameterDAO: SystemParameterDAOProtocol {
    static let instance = SystemParameterDAO()
    private var parameters: Array<SystemParameter>!
    
    internal init() {
        self.parameters = fetchParameters()
    }
    
    public func getSystemParameter(with key: Constants.SystemParameters, formID: Int? = nil) -> SystemParameter? {
        if let formID = formID {
            return parameters.first(where: { $0.parameterKey == key.rawValue && $0.formID == formID })
        } else {
            return parameters.first(where: { $0.parameterKey == key.rawValue })
        }
    }

    public func getSystemParameter(with key: String, formID: Int? = nil) -> SystemParameter? {
        if let formID = formID {
            return parameters.first(where: { $0.parameterKey == key && $0.formID == formID })
        } else {
            return parameters.first(where: { $0.parameterKey == key })
        }
    }
    
    // MARK: - Internal methods
    private func fetchParameters() -> Array<SystemParameter> {
        let query = "SELECT * FROM SystemParameter"
        
        var parameters = Array<SystemParameter>()
        
        do {
            parameters = try Database.instance.db.prepare(query).map { row in
                return SystemParameter(
                    id: Int(row[0] as! Int64),
                    formID: row[1] as? Int,
                    parameterKey: row[2] as! String,
                    parameterValue: row[3] as! String)
            }
        } catch {
            print("FetchParameters failled: \(error.localizedDescription)")
        }
        
        return parameters
    }
}
