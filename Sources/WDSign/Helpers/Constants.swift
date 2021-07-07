//
//  Constants.swift
//  
//
//  Created by Renan Maganha on 07/07/21.
//

import Foundation

final class Constants {
    enum SystemParameters: String {
        /// Colors
        case Color1 = "color_1"
        case Color2 = "color_2"
        case Color3 = "color_3"
        case Color4 = "color_4"
        case Color5 = "color_5"
        case Color6 = "color_6"
        case Color7 = "color_7"
        case Color8 = "color_8"
        case Color9 = "color_9"
        case Color10 = "color_10"
        case Color11 = "color_11"
        case Color12 = "color_12"
        case Color13 = "color_13"
        case Color14 = "color_14"
        case Color15 = "color_15"
        case Color16 = "color_16"
        case Color17 = "color_17"
        case Color18 = "color_18"
        case Color19 = "color_19"
        case Color20 = "color_20"
        case Color21 = "color_21"
    }
    
    enum SystemResources: String {
        case Cancel = "cancel"
        case Save = "save"
        case Sign = "sign"
        case SignHere = "sign_here"
        case Clean = "clean"
    }
    
    enum SubscriberType: String {
        case User = "Usuário"
        case Manager = "Gerente"
        case UserAndManager = "Usuário e gerente"
        case UserAndSubordinate = "Usuário e subordinado"
        case Form = "Formulário"
        case UserAndForm = "Usuário e formulário"
        case Subordinate = "Subordinado"

        var numberOfSignatureFields: Int {
            switch self {
            case .User: return 1
            case .Manager: return 1
            case .UserAndManager: return 2
            case .UserAndSubordinate: return 2
            case .Form: return 1
            case .UserAndForm: return 2
            case .Subordinate: return 1
            }
        }
    }
    
    enum PlaceholderSubscriberType: String {
        case User = "{USER_ID}"
        case Manager = "{USER_MANAGER_ID}"
        case Subordinate = "{USER_SUBORDINATE_ID}"
        case Form = "{FORM_RECORD_ID}"
    }
}
