//
//  InputView.swift
//  Welfare Helper
//
//  Created by Cyrus on 6/5/2022.
//

import SwiftUI

struct InputView: View {
    @State private var isSpeaking = false
    
    var body: some View {
        VStack {
            Text("Briefly introduce yourself and see the welfares that suit you")
                .font(.headline)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center
                )
                .foregroundColor(Main.primaryThemeYellow.theme.accentColor)
                .padding()
            
            Image("mic_FILL0_wght400_GRAD0_opsz48")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Main.primaryThemeYellow.theme.accentColor)
                .frame(width: 75.0, height: 75.0)
                .padding()
            
        }
        .background(RoundedRectangle(cornerRadius: 16.0)
            .fill(Main.primaryThemeYellow.theme.mainColor)
            .shadow(radius: 3)
        )
        .padding()
        
        if !isSpeaking {
            
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
            .previewLayout(.fixed(width: 400, height: 350))
    }
}
