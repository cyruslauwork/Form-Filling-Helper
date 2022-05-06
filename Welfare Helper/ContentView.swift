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
    
    private let JSONDataFromInternet: [CardViewStruct] = [
        CardViewStruct(title: "No Data", desc: "No Data", info: "No Data", theURL: "https://www.google.com/maps"),
        CardViewStruct(title: "No Data", desc: "No Data", info: "No Data", theURL: "https://www.google.com/maps"),
        CardViewStruct(title: "No Data", desc: "No Data", info: "No Data", theURL: "https://www.google.com/maps"),
        CardViewStruct(title: "No Data", desc: "No Data", info: "No Data", theURL: "https://www.google.com/maps")
    ]
    private let JSONDataFromLocal: [CardViewStruct] = [
        CardViewStruct(title: "No Data", desc: "No Data", info: "No Data", theURL: "https://www.google.com/maps"),
        CardViewStruct(title: "No Data", desc: "No Data", info: "No Data", theURL: "https://www.google.com/maps"),
        CardViewStruct(title: "No Data", desc: "No Data", info: "No Data", theURL: "https://www.google.com/maps"),
        CardViewStruct(title: "No Data", desc: "No Data", info: "No Data", theURL: "https://www.google.com/maps")
    ]
    
    var body: some View {
        GeometryReader { metrics in
            LazyVStack{
                ScrollView(.vertical) {
                    header
                    
                    if !bookmarksPresented {
                        InputView()
                            .frame(width: metrics.size.width * 1, height: 350, alignment: .center)
                            .transition(.slide)
                        
                        ForEach(JSONDataFromInternet) { data in
//                            CardView(cardViewStruct: CardViewStruct.sampleData)
                            CardView(cardViewStruct: data)
                                .frame(width: metrics.size.width * 1, height: .infinity, alignment: .center)
                                .transition(.slide)
                        }
                    } else {
                        ForEach(JSONDataFromInternet) { data in
//                            CardView(cardViewStruct: CardViewStruct.sampleData)
                            CardView(cardViewStruct: data)
                                .frame(width: metrics.size.width * 1, height: .infinity, alignment: .center)
                                .transition(.slide)
                        }
                    }
                }
                .frame(width: metrics.size.width * 1, height: metrics.size.height * 1, alignment: .center)
                .background(bookmarksPresented ? Main.primaryThemeRed.theme.mainColor : Main.primaryThemeWhite.theme.mainColor)
            }
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut) { bookmarksPresented.toggle() } // To enable animation
                }) {
                    Image(bookmarksPresented ? "home_FILL0_wght400_GRAD0_opsz48" : "bookmarks_FILL0_wght400_GRAD0_opsz48")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(bookmarksPresented ? Main.primaryThemeRed.theme.accentColor : Main.primaryThemeRed.theme.mainColor)
                        .frame(width: 75.0, height: 75.0)
                }
            }
            
            if !bookmarksPresented {
                Text("Welcome to \nWelfare Helper!")
                    .font(.largeTitle.weight(.bold))
                    .transition(.slide)
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
