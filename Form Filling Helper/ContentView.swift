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
        GeometryReader { metrics in
            LazyVStack{
                ScrollView(.vertical) {
                    InputView()
                        .frame(width: metrics.size.width * 1, height: 350, alignment: .center)
                
                    CardView(cardViewStruct: CardViewStruct.sampleData)
                        .frame(width: metrics.size.width * 1, height: .infinity, alignment: .center)
                }
                .frame(width: metrics.size.width * 1, height: metrics.size.height * 1, alignment: .center)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
