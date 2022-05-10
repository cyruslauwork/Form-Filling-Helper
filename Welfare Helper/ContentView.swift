//
//  ContentView.swift
//  Welfare Helper
//
//  Created by Cyrus on 2/5/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var bookmarksPresented: Bool = false
    @StateObject var main = Main() // temporaryStorage_ObservableObject 2
        
    // JSON 3
    @State private var JSONDataFromInternet: [CardViewStruct] = [CardViewStruct]()
    @State private var JSONDataFromLocal: [CardViewStruct] = [CardViewStruct]()
    // JSON 3 end
    
    @StateObject var speechRecognizer = SpeechRecognizer()
            
    var body: some View {
        GeometryReader { metrics in // Enable screensize percentage calculation
            LazyVStack{
                ScrollView(.vertical) {
                    self.header
                    
                    if !self.bookmarksPresented {
                        InputView(
                            main: self.main // temporaryStorage_ObservableObject 6
                        )
                        .frame(height: 350)
                        .transition(.slide)
                        
                        HStack{}.onAppear(){
                            // JSON 4
                            // URL Method
                            let urlString = "https://raw.githubusercontent.com/cyruslauwork/Welfare-Helper/main/Welfare%20Helper/JSON/data.json"
                            self.loadJson(fromURLString: urlString) { (result) in
                                switch result {
                                case .success(let data):
                                    self.parse(jsonData: data)
                                case .failure(let error):
                                    print(error)
                                }
                            }
                            // JSON 4 end
                        }
                                                                        
                        ForEach(self.JSONDataFromInternet, id: \.self) { data in
//                            CardView(cardViewStruct: CardViewStruct.sampleData)

                            ForEach(data.conditions, id: \.self) { el in
                                // "data.conditions" conform to "CardViewStruct.conditions",
                                // and the "data.conditions" array is now parsed.

//                                if ARRAY.contains(where: {$0.caseInsensitiveCompare(el) == .orderedSame}) { // Matching from an Array
                                if self.speechRecognizer.transcript.range(of: el, options: .caseInsensitive) != nil { // Matching from a String
                                    CardView(cardViewStruct: data, isBookmarksPage: CardViewBookmarks(bookmarksPage: false))
                                        .transition(.slide)
                                }
                            }
                        }
                    } else {
                        HStack{}.onAppear(){
                            // JSON 4
                            // Local Method
                            if let localData = self.readLocalFile(forName: "data") {
                                self.parse(jsonData: localData)
                            }
                            // JSON 4 end
                        }
                        
                        ForEach(self.JSONDataFromLocal, id: \.self) { data in
//                            CardView(cardViewStruct: CardViewStruct.sampleData)

                            CardView(cardViewStruct: data, isBookmarksPage: CardViewBookmarks(bookmarksPage: true))
                                .transition(.slide)
                        }
                    }
                }
                .frame(width: metrics.size.width * 1, height: metrics.size.height * 1, alignment: .center)
                .background(self.bookmarksPresented ? ColorPalette.primaryThemeRed.theme.mainColor : ColorPalette.primaryThemeWhite.theme.mainColor)
            }
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut) { self.bookmarksPresented.toggle() } // To enable animation
                }) {
                    Image(self.bookmarksPresented ? "home_FILL0_wght400_GRAD0_opsz48" : "bookmarks_FILL0_wght400_GRAD0_opsz48")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(self.bookmarksPresented ? ColorPalette.primaryThemeRed.theme.accentColor : ColorPalette.primaryThemeRed.theme.mainColor)
                        .frame(width: 75.0, height: 75.0)
                }
            }
            
            if self.main.recordingTimes == 0 { // temporaryStorage_ObservableObject 6
                if !self.bookmarksPresented {
                    Text("Welcome to \nWelfare Helper!")
                        .font(.system(size: 45, weight: .bold, design: .default))
                        .transition(.slide)
                }
            }
        }
        .padding()
        .foregroundColor(ColorPalette.primaryThemeRed.theme.accentColor)
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
    private func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) { // URL Method
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            
            urlSession.resume()
        }
    }
    // JSON end
    // JSON 2
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(CardViewStructs.self, from: jsonData)
            
            self.JSONDataFromInternet = decodedData.Welfares
            self.JSONDataFromLocal = decodedData.Welfares
        } catch {
            print("decode error")
        }
    }
    // JSON 2 end
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
