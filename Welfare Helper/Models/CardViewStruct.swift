//
//  CardView.swift
//  Welfare Helper
//
//  Created by Cyrus on 2/5/2022.
//

import Foundation

struct CardViewStruct: Codable, Hashable {
    var id: Int
    var title: String
    var desc: String
    var info: String
    var theURL: String
    var conditions: [String]
    
    init(id: Int, title: String, desc: String, info: String, theURL: String, conditions: [String]) { // Use init() to generate UUID by UUID()
        self.id = id
        self.title = title
        self.desc = desc
        self.info = info
        self.theURL = theURL
        self.conditions = conditions
    }
}

extension CardViewStruct {
    static let sampleData: CardViewStruct = CardViewStruct(id: 1, title: "No Data", desc: "No Data", info: "No Data", theURL: "https://www.google.com/maps", conditions: ["poor","without income"])
}
