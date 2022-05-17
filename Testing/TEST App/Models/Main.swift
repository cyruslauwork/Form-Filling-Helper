//
//  Main.swift
//  TEST App
//
//  Created by someone on 17/5/2022.
//

// * temporaryStorage_ObservableObject

import Foundation

class Main: ObservableObject {
    @Published var recordingTimes: Int = 0
    @Published var isRecording: Bool = false
}
