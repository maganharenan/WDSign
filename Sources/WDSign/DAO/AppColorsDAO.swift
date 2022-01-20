//
//  AppColorsDAO.swift
//  
//
//  Created by Renan Maganha on 07/07/21.
//

import SwiftUI
import UIKit

final class AppColorsDAO {
    static var instance : AppColorsDAO = {
        return AppColorsDAO()
    }()

    static private let parameterManager = SystemParameterDataManager.instance

    enum Colors: String {
        case color21 = "color_21"
        case color22 = "color_22"
        case color23 = "color_23"
        case color24 = "color_24"
        case color25 = "color_25"
        case color26 = "color_26"
        case color27 = "color_27"
        case color28 = "color_28"
        case color29 = "color_29"
        case color30 = "color_30"
        case color31 = "color_31"
        case color32 = "color_32"
        //case color33 = "color_33"
        case color34 = "color_34"
        case color35 = "color_35"
        case color36 = "color_36"
        case color37 = "color_37"
        case color38 = "color_38"
        case color39 = "color_39"
        case color40 = "color_40"
        case color41 = "color_41"
        case color42 = "color_42"
        case color43 = "color_43"
        case color44 = "color_44"
        case color45 = "color_45"

        var hexValue: String {
            return getHexValue(for: self)
        }

        var colorValue: Color {
            return Color(UIColor(hexString: hexValue) ?? .clear)
        }

        var uiColorValue: UIColor {
            UIColor(hexString: hexValue) ?? .clear
        }
    }

    enum ColorFor {
        case listHeaderBackground
        case statisticsText
        case commonText
        case selectedSegmentText
        case headerText
        case statisticsPositiveBox
        case lateralMenu
        case generalIcons
        case activeTabBarSegment
        case auditHighlightedCell
        case evaluationAverageCell
        case subtitles
        case expandCollapseIcon
        case placeholders
        case counters
        case verticalLineTimeField
        case inactiveEntitiesBar
        case checkInWidgetTags
        case masterSections
        case selectedSegmentController
        case affirmativeButtons
        case pinExplanationTextTitle
        case pinKeyboard
        case concludeButton
        case selectedRegisters
        case tabBar
        case filterSections
        case listSearchBox
        case notSelecterSegmentController
        case relationshipTagUpTo2Cycles
        case relationshipCellBackground
        case controlledDrugs
        case deleteButton
        case eraseButton
        case currentDayAtCalendar
        case currentHourAtCalendar
        case currentDayAtBirthdayWidget
        case wrongStockTextFieldValue
        case statisticsNegativeBox
        case negativeFilterIcon
        case negativeTag
        case bithdayPersonOfTheDayFlag
        case WDReports
        case attentionFilterColor
        case pendentSign
        case relationshipTag3cyclesAgo
        case checkInText
        case WDLearning
        case separatorLines
        case scrollViewIndicators
        case resendButtonInactive
        case progressBarNotConcluded
        case journeyControlWidgetVerticalLines
        case inactiveIcons
        case inactiveItemsText
        case inactiveRelationshipsTag
        case pendingBorder
        case relationshipTag2cyclesAgo
        case inactiveBorder
        case attentionTag
        case master
        case tabBarBackground
        case headers
        case inactiveTabBarItens
        case relationshipCustomerTags
        case selectedRegisterAtMaster
        case unselectedSegment
        case notSelectedSegmentAtEvaluation
        case WDForms
        case WDCRM
        case WDStock
        case WDSign
        case WDPromo

        var hexValue: String {
            switch self {
            case .listHeaderBackground: return "#FFFFFF"
            case .statisticsText: return "#FFFFFF"
            case .commonText: return "#000000"
            case .selectedSegmentText: return "#FFFFFF"
            case .headerText: return "#FFFFFF"
            case .statisticsPositiveBox: return Colors.color41.hexValue
            case .lateralMenu: return Colors.color21.hexValue
            case .generalIcons: return Colors.color21.hexValue
            case .activeTabBarSegment: return Colors.color21.hexValue
            case .auditHighlightedCell: return Colors.color22.hexValue
            case .evaluationAverageCell: return Colors.color22.hexValue
            case .subtitles: return Colors.color23.hexValue
            case .expandCollapseIcon: return Colors.color23.hexValue
            case .placeholders: return Colors.color23.hexValue
            case .counters: return Colors.color23.hexValue
            case .verticalLineTimeField: return Colors.color23.hexValue
            case .inactiveEntitiesBar: return Colors.color23.hexValue
            case .checkInWidgetTags: return Colors.color23.hexValue
            case .masterSections: return Colors.color24.hexValue
            case .selectedSegmentController: return Colors.color24.hexValue
            case .affirmativeButtons: return Colors.color25.hexValue
            case .pinExplanationTextTitle: return Colors.color25.hexValue
            case .pinKeyboard: return Colors.color25.hexValue
            case .concludeButton: return Colors.color25.hexValue
            case .selectedRegisters: return Colors.color26.hexValue
            case .tabBar: return Colors.color26.hexValue
            case .filterSections: return Colors.color26.hexValue
            case .listSearchBox: return Colors.color26.hexValue
            case .notSelecterSegmentController: return Colors.color26.hexValue
            case .relationshipTagUpTo2Cycles: return Colors.color26.hexValue
            case .relationshipCellBackground: return Colors.color26.hexValue
            case .controlledDrugs: return Colors.color27.hexValue
            case .currentDayAtCalendar: return Colors.color28.hexValue
            case .currentHourAtCalendar: return Colors.color28.hexValue
            case .currentDayAtBirthdayWidget: return Colors.color28.hexValue
            case .wrongStockTextFieldValue: return Colors.color28.hexValue
            case .statisticsNegativeBox: return Colors.color28.hexValue
            case .negativeFilterIcon: return Colors.color28.hexValue
            case .negativeTag: return Colors.color28.hexValue
            case .bithdayPersonOfTheDayFlag: return Colors.color28.hexValue
            case .WDReports: return Colors.color28.hexValue
            case .attentionFilterColor: return Colors.color29.hexValue
            case .pendentSign: return Colors.color29.hexValue
            case .relationshipTag3cyclesAgo: return Colors.color29.hexValue
            case .checkInText: return Colors.color29.hexValue
            case .WDLearning: return Colors.color29.hexValue
            case .separatorLines: return Colors.color30.hexValue
            case .scrollViewIndicators: return Colors.color30.hexValue
            case .resendButtonInactive: return Colors.color30.hexValue
            case .progressBarNotConcluded: return Colors.color30.hexValue
            case .journeyControlWidgetVerticalLines: return Colors.color30.hexValue
            case .inactiveIcons: return Colors.color30.hexValue
            case .inactiveItemsText: return Colors.color31.hexValue
            case .inactiveRelationshipsTag: return Colors.color31.hexValue
            case .pendingBorder: return Colors.color32.hexValue
            case .relationshipTag2cyclesAgo: return Colors.color32.hexValue
            case .inactiveBorder: return Colors.color37.hexValue
            case .attentionTag: return Colors.color34.hexValue
            case .master: return Colors.color35.hexValue
            case .tabBarBackground: return Colors.color35.hexValue
            case .headers: return Colors.color36.hexValue
            case .inactiveTabBarItens: return Colors.color37.hexValue
            case .relationshipCustomerTags: return Colors.color37.hexValue
            case .selectedRegisterAtMaster: return Colors.color38.hexValue
            case .unselectedSegment: return Colors.color38.hexValue
            case .notSelectedSegmentAtEvaluation: return Colors.color39.hexValue
            case .WDForms: return Colors.color40.hexValue
            case .WDCRM: return Colors.color41.hexValue
            case .WDStock: return Colors.color42.hexValue
            case .WDSign: return Colors.color43.hexValue
            case .WDPromo: return Colors.color44.hexValue
            case .deleteButton: return Colors.color45.hexValue
            case .eraseButton: return Colors.color45.hexValue
            }
        }

        var uiColorValue: UIColor {
            UIColor(hexString: hexValue) ?? .clear
        }

        var colorValue: Color {
            return Color(uiColorValue)
        }


    }

    static private func getHexValue(for color: Colors) -> String {
        return parameterManager.getParameter(key: color.rawValue)
    }
}
