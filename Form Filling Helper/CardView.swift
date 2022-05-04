//
//  CardView.swift
//  Form Filling Helper
//
//  Created by Cyrus on 2/5/2022.
//

import SwiftUI

struct CardView: View {
    var cardViewStruct: CardViewStruct
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(cardViewStruct.title)
                .font(.title.weight(.bold))
                .accessibilityAddTraits(.isHeader)
            Spacer()
            
            Text(cardViewStruct.title)
                .font(.headline)
                .accessibilityLabel("\(cardViewStruct.title)")
            Spacer()
            
            Link(cardViewStruct.info, destination: URL(string: "https://www.google.com/maps")!)
                .font(.headline.weight(.bold))
                .accessibilityLabel("\(cardViewStruct.info)")
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
        .padding()
        .foregroundColor(Main.primaryThemeBlue.theme.accentColor)
        .background(Main.primaryThemeBlue.theme.mainColor)
    }
}

struct CardView_Previews: PreviewProvider {
    static var cardViewStruct = CardViewStruct.sampleData
    
    static var previews: some View {
        CardView(cardViewStruct: cardViewStruct)
            .previewLayout(.fixed(width: 400, height: 75))
    }
}
