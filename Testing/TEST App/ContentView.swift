//
//  ContentView.swift
//  TEST App
//
//  Created by someone on 17/5/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var main = Main() // temporaryStorage_ObservableObject 2
        
    // JSON 3
    @State private var JSONDataFromLocal: [CardViewStruct] = [CardViewStruct]()
    // JSON 3 end
    
    @StateObject var speechRecognizer = SpeechRecognizer() // speechRecognizer 2
            
    var body: some View {
        GeometryReader { metrics in // Enable screensize percentage calculation
            LazyVStack{
                ScrollView(.vertical) {
                    self.header
                    
                    HStack{}.onAppear(){
                        // JSON 4
                        // Local Method
                        if let localData = self.readLocalFile(forName: "data") {
                            self.parse(jsonData: localData)
                        }
                        // JSON 4 end
                    }
                    
                    InputView(
                        speechRecognizer: self.speechRecognizer, // speechRecognizer 2
                        main: self.main // temporaryStorage_ObservableObject 6
                    )
                    .frame(height: 350)

                    // autoRefreshView
                    TimelineView(.periodic(from: .now, by: 2.5)) { timeline in // Auto refresh in every particular time
                        ForEach(self.JSONDataFromLocal, id: \.self) { data in

                            ForEach(data.conditions, id: \.self) { el in
                                // "data.conditions" conform to "CardViewStruct.conditions",
                                // and the "data.conditions" array is now parsed.

//                                if ARRAY.contains(where: {$0.caseInsensitiveCompare(el) == .orderedSame}) { // Matching from an Array
                                if self.speechRecognizer.transcript.range(of: el, options: .caseInsensitive) != nil { // Matching from a String
                                    CardView(cardViewStruct: data)
                                }
                            }
                        }
                    }
                    // autoRefreshView end
                    
                }
                .frame(width: metrics.size.width * 1, height: metrics.size.height * 1, alignment: .center)
                .background(ColorPalette.primaryThemeBlack.theme.mainColor)
            }
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading) {
            if self.main.recordingTimes == 0 { // temporaryStorage_ObservableObject 6
                Text("Welcome to \nTEST App!")
                    .font(.system(size: 45, weight: .bold, design: .default))
            }
        }
        .padding()
        .foregroundColor(ColorPalette.primaryThemeBlack.theme.accentColor)
    }
    
    // JSON
    private func readLocalFile(forName name: String) -> Data? { // Local Method
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    // JSON end
    // JSON 2
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(CardViewStructs.self, from: jsonData)
            
            self.JSONDataFromLocal = decodedData.Tests.self
        } catch {
            print("decode error")
        }
    }
    // JSON 2 end
}
