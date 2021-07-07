//
//  SystemResource+TranslatedValue.swift
//  
//
//  Created by Renan Magnaha on 07/07/21.
//

import Foundation

extension Constants.SystemResources {
    func translateResource(_ formID: Int? = nil) -> String {
        return SystemResourceDAO.instance.getSystemResource(with: self, formID: formID)?.value ?? ""
    }
}
