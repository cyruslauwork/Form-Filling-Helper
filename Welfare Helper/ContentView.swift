//
//  ContentView.swift
//  Welfare Helper
//
//  Created by Cyrus on 2/5/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var cardViewData = CardViewDataSrc()
    @State private var bookmarksPresented = false
    @State private var homepageBGColor = Main.primaryThemeWhite.theme.mainColor
    
    var body: some View {
        GeometryReader { metrics in
            LazyVStack{
                ScrollView(.vertical) {
                    header
                    
                    if !bookmarksPresented {
                        InputView()
                            .frame(width: metrics.size.width * 1, height: 350, alignment: .center)
                        
                        CardView(cardViewStruct: CardViewStruct.sampleData)
                            .frame(width: metrics.size.width * 1, height: .infinity, alignment: .center)
                    } else {
                        
                    }
                }
                .frame(width: metrics.size.width * 1, height: metrics.size.height * 1, alignment: .center)
                .background(homepageBGColor)
            }
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut) { bookmarksPresented.toggle() }
                }) {
                    Image("bookmarks_FILL0_wght400_GRAD0_opsz48")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Main.primaryThemeRed.theme.mainColor)
                        .frame(width: 75.0, height: 75.0)
                }
            }
            
            if !bookmarksPresented {
                Text("Welcome to \nWelfare Helper!")
                    .font(.largeTitle.weight(.bold))
            }
        }
        .padding()
        .foregroundColor(Main.primaryThemeRed.theme.accentColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
