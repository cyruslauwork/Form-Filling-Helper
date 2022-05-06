//
//  CardView.swift
//  Welfare Helper
//
//  Created by Cyrus on 2/5/2022.
//

import SwiftUI

struct CardView: View {
    @State private var isExpanded: Bool = false
    
    var cardViewStruct: CardViewStruct
    
    var body: some View {
        content
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            header
            Spacer()
            
            if isExpanded {
                Text(cardViewStruct.title)
                    .font(.headline)
                    .accessibilityLabel("\(cardViewStruct.title)")
                Spacer()
                
                Link(cardViewStruct.info, destination: URL(string: cardViewStruct.theURL)!)
                    .font(.headline.weight(.bold))
                    .accessibilityLabel("\(cardViewStruct.info)")
            }
        }
        .padding()
        .foregroundColor(Main.primaryThemeBlue.theme.accentColor)
        .background(RoundedRectangle(cornerRadius: 16.0)
            .fill(Main.primaryThemeBlue.theme.mainColor)
            .shadow(radius: 3)
        )
        .padding()
    }
    
    private var header: some View {
        HStack {
            Text(cardViewStruct.title)
                .font(.title2.weight(.bold))
                .accessibilityAddTraits(.isHeader)
            Spacer()
            
            Image("expand_more_FILL0_wght400_GRAD0_opsz48")
                .renderingMode(.template)
                .foregroundColor(Main.primaryThemeBlue.theme.accentColor)
        }
        .onTapGesture {
            withAnimation { isExpanded.toggle() }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var cardViewStruct = CardViewStruct.sampleData
    
    static var previews: some View {
        CardView(cardViewStruct: cardViewStruct)
            .previewLayout(.fixed(width: 400, height: 400))
    }
}
