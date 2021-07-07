//
//  AppColorsDAO.swift
//  
//
//  Created by Renan Maganha on 07/07/21.
//

import Foundation

final class AppColorsDAO {
    static let instance = AppColorsDAO()
    
    var system_color_1 = ""
    var system_color_2 = ""
    var system_color_3 = ""
    var system_color_4 = ""
    var system_color_5 = ""
    var system_color_6 = ""
    var system_color_7 = ""
    var system_color_8 = ""
    var system_color_9 = ""
    var system_color_10 = ""
    var system_color_11 = ""
    var system_color_12 = ""
    var system_color_13 = ""
    var system_color_14 = ""
    var system_color_15 = ""
    var system_color_16 = ""
    var system_color_17 = ""
    var system_color_18 = ""
    var system_color_19 = ""
    var system_color_20 = ""
    var system_color_21 = ""
    
    internal init() {
        let parameterManager = SystemParameterDAO.instance
        
        self.system_color_1 = parameterManager.getSystemParameter(with: .Color1)?.parameterValue ?? ""
        self.system_color_2 = parameterManager.getSystemParameter(with: .Color2)?.parameterValue ?? ""
        self.system_color_3 = parameterManager.getSystemParameter(with: .Color3)?.parameterValue ?? ""
        self.system_color_4 = parameterManager.getSystemParameter(with: .Color4)?.parameterValue ?? ""
        self.system_color_5 = parameterManager.getSystemParameter(with: .Color5)?.parameterValue ?? ""
        self.system_color_6 = parameterManager.getSystemParameter(with: .Color6)?.parameterValue ?? ""
        self.system_color_7 = parameterManager.getSystemParameter(with: .Color7)?.parameterValue ?? ""
        self.system_color_8 = parameterManager.getSystemParameter(with: .Color8)?.parameterValue ?? ""
        self.system_color_9 = parameterManager.getSystemParameter(with: .Color9)?.parameterValue ?? ""
        self.system_color_10 = parameterManager.getSystemParameter(with: .Color10)?.parameterValue ?? ""
        self.system_color_11 = parameterManager.getSystemParameter(with: .Color11)?.parameterValue ?? ""
        self.system_color_12 = parameterManager.getSystemParameter(with: .Color12)?.parameterValue ?? ""
        self.system_color_13 = parameterManager.getSystemParameter(with: .Color13)?.parameterValue ?? ""
        self.system_color_14 = parameterManager.getSystemParameter(with: .Color14)?.parameterValue ?? ""
        self.system_color_15 = parameterManager.getSystemParameter(with: .Color15)?.parameterValue ?? ""
        self.system_color_16 = parameterManager.getSystemParameter(with: .Color16)?.parameterValue ?? ""
        self.system_color_17 = parameterManager.getSystemParameter(with: .Color17)?.parameterValue ?? ""
        self.system_color_18 = parameterManager.getSystemParameter(with: .Color18)?.parameterValue ?? ""
        self.system_color_19 = parameterManager.getSystemParameter(with: .Color19)?.parameterValue ?? ""
        self.system_color_20 = parameterManager.getSystemParameter(with: .Color20)?.parameterValue ?? ""
        self.system_color_21 = parameterManager.getSystemParameter(with: .Color21)?.parameterValue ?? ""
    }
}
