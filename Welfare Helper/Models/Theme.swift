//
//  Theme.swift
//  Welfare Helper
//
//  Created by Cyrus on 2/5/2022.
//

import SwiftUI

// How to use:
// .fill(Main.black.theme.accentColor)



struct Main {
    var theme: Theme
    
    init(theme: Theme) {
        self.theme = theme
    }
    
}

extension Main {
    static let primaryThemeBlack: Main = Main(theme: .primaryThemeBlack)
    static let primaryThemeWhite: Main = Main(theme: .primaryThemeWhite)
    static let primaryThemeRed: Main = Main(theme: .primaryThemeRed)
    static let primaryThemeYellow: Main = Main(theme: .primaryThemeYellow)
    static let primaryThemeBlue: Main = Main(theme: .primaryThemeBlue)
}

enum Theme: String
//, CaseIterable, Identifiable // themePicker
{
    case primaryThemeBlack
    case primaryThemeWhite
    case primaryThemeRed
    case primaryThemeYellow
    case primaryThemeBlue
    
    var accentColor: Color {
        switch self {
        case .primaryThemeRed, .primaryThemeYellow, .primaryThemeWhite: return .black
        case .primaryThemeBlue, .primaryThemeBlack: return .white
        }
    }
    var mainColor: Color {
        Color(rawValue)
    }
    var name: String {
        rawValue.capitalized
    }
    
      // themePicker 2
//        var id: String {
//            name
//        }
      // themePicker 2 end
    
}

// themePicker 3 (ThemePicker.swift)
//import SwiftUI
//
//struct ThemePicker: View {
//    @Binding var selection: Theme
//
//    var body: some View {
//        Picker("Theme", selection: $selection) {
//            ForEach(Theme.allCases) { theme in
//                ThemeView(theme: theme)
//                    .tag(theme)
//            }
//        }
//    }
//}
//
//struct ThemePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemePicker(selection: .constant(.black))
//    }
//}
// themePicker 3 end

// themePicker 4
//import SwiftUI
//
//struct ThemeView: View {
//    let theme: Theme
//
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 4)
//                .fill(theme.mainColor)
//
//            Label(theme.name, systemImage: "paintpalette")
//                .padding(4)
//        }
//        .foregroundColor(theme.accentColor)
//        .fixedSize(horizontal: false, vertical: true)
//    }
//}
//
//struct ThemeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeView(theme: .yellow)
//    }
//}
// themePicker 4 end

// How to use themePicker:
// @State var selection: Theme
// ThemePicker(selection: $data.theme)
