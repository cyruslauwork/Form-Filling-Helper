//
//  ContentView.swift
//  Welfare Helper
//
//  Created by Cyrus on 2/5/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var bookmarksPresented: Bool = false
    @StateObject var main = Main()
    @State var recordingTimes: Int = 0
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect() // Timer
    
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
                            .frame(height: 350)
                            .transition(.slide)
                        
                        ForEach(JSONDataFromInternet) { data in
//                            CardView(cardViewStruct: CardViewStruct.sampleData)
                            CardView(cardViewStruct: data, isBookmarksPage: CardViewBookmarks(bookmarksPage: false))
                                .transition(.slide)
                        }.onAppear(){
                            // JSON 3
                            // URL Method
                            let urlString = "https://github.com/cyruslauwork/Welfare-Helper/tree/main/Welfare%20Helper/JSON/data.json"
                            
                            self.loadJson(fromURLString: urlString) { (result) in
                                switch result {
                                case .success(let data):
                                    self.parse(jsonData: data)
                                case .failure(let error):
                                    print(error)
                                }
                            }
                            // JSON 3 end
                        }
                    } else {
                        ForEach(JSONDataFromLocal) { data in
//                            CardView(cardViewStruct: CardViewStruct.sampleData)
                            CardView(cardViewStruct: data, isBookmarksPage: CardViewBookmarks(bookmarksPage: true))
                                .transition(.slide)
                        }.onAppear(){
                            // JSON 3
                            // Local Method
                            if let localData = self.readLocalFile(forName: "data") {
                                self.parse(jsonData: localData)
                            }
                            // JSON 3 end
                        }
                    }
                }
                .frame(width: metrics.size.width * 1, height: metrics.size.height * 1, alignment: .center)
                .background(bookmarksPresented ? ColorPalette.primaryThemeRed.theme.mainColor : ColorPalette.primaryThemeWhite.theme.mainColor)
            }
        }
        // Timer 2
        .onReceive(timer) { time in
            // Make View update automatically
            recordingTimes = main.recordingTimes
        }
        // Timer 2 end
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
                        .foregroundColor(bookmarksPresented ? ColorPalette.primaryThemeRed.theme.accentColor : ColorPalette.primaryThemeRed.theme.mainColor)
                        .frame(width: 75.0, height: 75.0)
                }
            }
            
            if recordingTimes == 0 {
                if !bookmarksPresented {
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
            let decodedData = try JSONDecoder().decode(CardViewStruct.self,
                                                       from: jsonData)
        } catch {
            print("decode error")
        }
    }
    // JSON 2 end
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
