//
//  InputView.swift
//  Form Filling Helper
//
//  Created by Cyrus on 6/5/2022.
//

import SwiftUI

struct InputView: View {
    var body: some View {
        Text("Briefly introduce yourself and see the welfares that suit you")
            .font(.headline)
            .padding()
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            )
            .background(RoundedRectangle(cornerRadius: 16.0)
                .fill(Main.primaryThemeYellow.theme.mainColor)
                .shadow(radius: 3)
            )
            .padding()
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
            .previewLayout(.fixed(width: 400, height: 350))
    }
}
