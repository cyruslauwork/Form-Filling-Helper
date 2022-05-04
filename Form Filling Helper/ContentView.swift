//
//  ContentView.swift
//  Form Filling Helper
//
//  Created by Cyrus on 2/5/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var cardViewData = CardViewDataSrc()
    
    var body: some View {
        LazyVStack{
            RoundedRectangle(cornerRadius: 16.0)
                .fill(Main.primaryThemeYellow.theme.mainColor)
            Text("Hello, world!")
                .padding()
            
            ScrollView(.horizontal) {
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
