//
//  Theme.swift
//  TEST App
//
//  Created by someone on 17/5/2022.
//

import SwiftUI

// How to use:
// .fill(Main.black.theme.accentColor)



struct ColorPalette {
    var theme: Theme
    
    init(theme: Theme) {
        self.theme = theme
    }
    
}

extension ColorPalette {
    static let primaryThemeBlack: ColorPalette = ColorPalette(theme: .primaryThemeBlack)
    static let primaryThemeWhite: ColorPalette = ColorPalette(theme: .primaryThemeWhite)
}

enum Theme: String
{
    case primaryThemeBlack
    case primaryThemeWhite
    
    var accentColor: Color {
        switch self {
        case .primaryThemeWhite: return .black
        case .primaryThemeBlack: return .white
        }
    }
    var mainColor: Color {
        Color(rawValue)
    }
    var name: String {
        rawValue.capitalized
    }
    
}
