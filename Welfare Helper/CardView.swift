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
        self.content
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            self.header
            Spacer()
            
            if self.isExpanded {
                Text(self.cardViewStruct.desc)
                    .font(.headline)
                    .accessibilityLabel("\(self.cardViewStruct.desc)")
                Spacer()
                    .padding(.top)
                
                Link(self.cardViewStruct.info, destination: URL(string: self.cardViewStruct.theURL)!)
                    .font(.headline.weight(.bold))
                    .accessibilityLabel("\(self.cardViewStruct.info)")
                Spacer()

                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.isBookmarksPage.BOOL.toggle()
                        
                        // userDefaults_bookmarksArray
                        if self.isBookmarksPage.BOOL {
                            if var Array = UserDefaults.standard.array(forKey: "bookmarksArray") {
                                
                                if !Array.contains(where: { $0 as! Int == self.cardViewStruct.id }) { // Check if value exists
                                    // Add a new element to the end of an Array.
                                    Array.append(self.cardViewStruct.id)
                                    
                                    UserDefaults.standard.set(Array, forKey: "bookmarksArray") // Reset array object
                                }
                            } else {
                                UserDefaults.standard.set([self.cardViewStruct.id], forKey: "bookmarksArray") // Set array object
                            }
                            
                        } else {
                            let rawArray: [Int] = UserDefaults.standard.array(forKey: "bookmarksArray") as! [Int]
                            let Array = rawArray.filter { $0 != self.cardViewStruct.id }
                            // A non-mutating alternative that will keep the original collection unchanged is to use filter to create a new collection without the elements you want removed
                            UserDefaults.standard.set(Array, forKey: "bookmarksArray") // Reset array object
                        }
                        // userDefaults_bookmarksArray end
                    }) {
                        Image(self.isBookmarksPage.BOOL ? "bookmark_remove_FILL0_wght400_GRAD0_opsz48" : "bookmark_add_FILL0_wght400_GRAD0_opsz48")
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
            Text(self.cardViewStruct.title)
                .font(.title2.weight(.bold))
                .accessibilityAddTraits(.isHeader)
            Spacer()
            
            Image("expand_more_FILL0_wght400_GRAD0_opsz48")
                .renderingMode(.template)
                .foregroundColor(ColorPalette.primaryThemeBlue.theme.accentColor)
        }
        .onTapGesture {
            withAnimation { self.isExpanded.toggle() }
        }
    }
}

struct CardViewBookmarks {
    var BOOL: Bool
    
    init(BOOL: Bool) {
        self.BOOL = BOOL
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
