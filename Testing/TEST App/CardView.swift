//
//  CardView.swift
//  TEST App
//
//  Created by someone on 17/5/2022.
//

import SwiftUI

struct CardView: View {
    var cardViewStruct: CardViewStruct
        
    var body: some View {
        self.content
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            self.header
            Spacer()
            
            Text(self.cardViewStruct.desc)
                .font(.headline)
                .accessibilityLabel("\(self.cardViewStruct.desc)")
            Spacer()
                .padding(.top)
            
            Link(self.cardViewStruct.info, destination: URL(string: self.cardViewStruct.theURL)!)
                .font(.headline.weight(.bold))
                .accessibilityLabel("\(self.cardViewStruct.info)")
        }
        .padding()
        .foregroundColor(ColorPalette.primaryThemeWhite.theme.accentColor)
        .background(RoundedRectangle(cornerRadius: 16.0)
            .fill(ColorPalette.primaryThemeWhite.theme.mainColor)
            .shadow(radius: 3)
        )
        .padding()
    }
    
    private var header: some View {
        HStack {
            Text(self.cardViewStruct.title)
                .font(.title2.weight(.bold))
                .accessibilityAddTraits(.isHeader)
            
            Spacer()
        }
    }
}
