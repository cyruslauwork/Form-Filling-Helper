//
//  InputView.swift
//  TEST App
//
//  Created by someone on 17/5/2022.
//

import SwiftUI
import AVFoundation // speechRecognizer

struct InputView: View {
    @ObservedObject var speechRecognizer: SpeechRecognizer // speechRecognizer 3
    @ObservedObject var main: Main // @ObservedObject or @StateObject, the latter is more reliable // temporaryStorage_ObservableObject 3
    
    @State var Transcription: String = "Briefly introduce yourself and see the smartphone that suit you"// speechRecognizer 6
    @State private var timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect() // Timer
    
    var body: some View {
        VStack {
            Text(self.Transcription) // speechRecognizer 8
                .font(.headline)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center
                )
                .foregroundColor(ColorPalette.primaryThemeWhite.theme.accentColor)
                .padding()
                // Timer 2
                .onReceive(self.timer) { time in
                    // Make View update automatically
                    if self.main.isRecording {
                        self.Transcription = self.speechRecognizer.transcript // speechRecognizer 7
                    }
                }
                // Timer 2 end
            
            Button(action: {
                withAnimation(.easeInOut) { self.main.isRecording.toggle() }
                
                if !self.main.isRecording {
                    self.stopTimer() // Timer 4
                    
                    self.speechRecognizer.stopTranscribing() // speechRecognizer 5
                    
                    self.Transcription = "Briefly introduce yourself and see the smartphone that suit you" // speechRecognizer 8
                } else {
                    self.startTimer() // Timer 4
                    
                    self.speechRecognizer.transcript = "Briefly introduce yourself..." // speechRecognizer 9
                    
                    // speechRecognizer 4
                    self.speechRecognizer.reset()
                    self.speechRecognizer.transcribe()
                    // speechRecognizer 4 end
                    
                    self.main.recordingTimes += 1 // temporaryStorage_ObservableObject 4
                }
            }) {
                Image(self.main.isRecording ? "restart_alt_FILL0_wght400_GRAD0_opsz48" : "mic_FILL0_wght400_GRAD0_opsz48")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(ColorPalette.primaryThemeWhite.theme.accentColor)
                    .frame(width: 75.0, height: 75.0)
                    .padding()
                    .accessibilityLabel(self.main.isRecording ? "with transcription" : "without transcription")
            }
        }
        .background(RoundedRectangle(cornerRadius: 16.0)
            .fill(ColorPalette.primaryThemeWhite.theme.mainColor)
            .shadow(radius: 3)
        )
        .padding()
    }
    
    // Timer 3
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    func startTimer() {
        self.timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    }
    // Timer end
}
