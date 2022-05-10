//
//  Main.swift
//  Welfare Helper
//
//  Created by Cyrus on 4/5/2022.
//

// * temporaryStorage_ObservableObject

import Foundation

class Main: ObservableObject {
    @Published var recordingTimes: Int = 0
    @Published var isRecording: Bool = false
}
