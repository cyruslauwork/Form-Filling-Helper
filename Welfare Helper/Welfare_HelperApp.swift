//
//  Welfare_HelperApp.swift
//  Welfare Helper
//
//  Created by Cyrus on 2/5/2022.
//

import SwiftUI

@main
struct Welfare_HelperApp: App {
    @StateObject var main = Main() // temporaryStorage_ObservableObject 2
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                main: main // temporaryStorage_ObservableObject 4
            )
        }
    }
}
