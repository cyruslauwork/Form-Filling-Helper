//
//  CardView.swift
//  Form Filling Helper
//
//  Created by Cyrus on 2/5/2022.
//

import Foundation

struct CardViewStruct: Identifiable, Codable {
    let id: UUID
    var title: String
    var desc: String
    var info: String
    var theURL: String
    
    init(id: UUID = UUID(), title: String, desc: String, info: String, theURL: String) { // Use init() to generate UUID by UUID()
        self.id = id
        self.title = title
        self.desc = desc
        self.info = info
        self.theURL = theURL
    }
    
}

extension CardViewStruct {
    static let sampleData: CardViewStruct = CardViewStruct(title: "No Data", desc: "No Data", info: "No Data", theURL: "https://www.google.com/maps")
}
