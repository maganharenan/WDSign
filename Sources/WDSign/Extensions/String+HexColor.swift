//
//  String+HexColor.swift
//  
//
//  Created by Renan Maganha on 07/07/21.
//

import SwiftUI

extension String {
    func getColorFromHex() -> Color {
        guard !self.isEmpty else { return Color.clear }
        
        return Color(UIColor(hexString: self) ?? UIColor.clear)
    }
}
