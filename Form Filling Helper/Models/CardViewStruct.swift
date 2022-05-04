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
    
    init(id: UUID = UUID(), title: String, desc: String, info: String) { // Use init() to generate UUID by UUID()
        self.id = id
        self.title = title
        self.desc = desc
        self.info = info
    }
    
}

extension CardViewStruct {
    static let sampleData: CardViewStruct = CardViewStruct(title: "No Data", desc: "No Data", info: "No Data")
}
