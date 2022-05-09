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
    @State var isBookmarksPage: CardViewBookmarks
        
    var body: some View {
        content
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            header
            Spacer()
            
            if isExpanded {
                Text(cardViewStruct.desc)
                    .font(.headline)
                    .accessibilityLabel("\(cardViewStruct.desc)")
                Spacer()
                    .padding(.top)
                
                Link(cardViewStruct.info, destination: URL(string: cardViewStruct.theURL)!)
                    .font(.headline.weight(.bold))
                    .accessibilityLabel("\(cardViewStruct.info)")
                Spacer()

                HStack {
                    Spacer()
                    
                    Button(action: {
                        isBookmarksPage.bookmarksPage.toggle()
                    }) {
                        Image(isBookmarksPage.bookmarksPage ? "bookmark_remove_FILL0_wght400_GRAD0_opsz48" : "bookmark_add_FILL0_wght400_GRAD0_opsz48")
                            .renderingMode(.template)
                            .foregroundColor(ColorPalette.primaryThemeBlue.theme.accentColor)
                    }
                }
            }
        }
        .padding()
        .foregroundColor(ColorPalette.primaryThemeBlue.theme.accentColor)
        .background(RoundedRectangle(cornerRadius: 16.0)
            .fill(ColorPalette.primaryThemeBlue.theme.mainColor)
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
                .foregroundColor(ColorPalette.primaryThemeBlue.theme.accentColor)
        }
        .onTapGesture {
            withAnimation { isExpanded.toggle() }
        }
    }
}

struct CardViewBookmarks {
    var bookmarksPage: Bool
    
    init(bookmarksPage: Bool) {
        self.bookmarksPage = bookmarksPage
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var cardViewStruct = CardViewStruct.sampleData
//
//    static var previews: some View {
//        CardView(cardViewStruct: cardViewStruct, isBookmarksPage: CardViewBookmarks(bookmarksPage: false))
//            .previewLayout(.fixed(width: 400, height: 400))
//    }
//}
