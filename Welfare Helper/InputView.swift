//
//  InputView.swift
//  Welfare Helper
//
//  Created by Cyrus on 6/5/2022.
//

import SwiftUI
import AVFoundation // speechRecognizer

struct InputView: View {
    @StateObject var speechRecognizer = SpeechRecognizer() // speechRecognizer
    @ObservedObject var main: Main // @ObservedObject or @StateObject, the latter is more reliable // temporaryStorage_ObservableObject 3
    
    @State var Transcription: String = "Briefly introduce yourself and see the welfares that suit you"// speechRecognizer 4
    let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect() // Timer
    
    var body: some View {
        VStack {
            Text(self.Transcription) // speechRecognizer 6
                .font(.headline)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center
                )
                .foregroundColor(ColorPalette.primaryThemeYellow.theme.accentColor)
                .padding()
                // Timer 2
                .onReceive(self.timer) { time in
                    // Make View update automatically
                    if self.main.isRecording {
                        self.Transcription = self.speechRecognizer.transcript // speechRecognizer 5
                    }
                }
                // Timer 2 end
            
            Button(action: {
                withAnimation(.easeInOut) { self.main.isRecording.toggle() }
                
                if !self.main.isRecording {
                    self.speechRecognizer.stopTranscribing() // speechRecognizer 3
                    
                    self.Transcription = "Briefly introduce yourself and see the welfares that suit you"
                } else {
                    self.speechRecognizer.transcript = "Briefly introduce yourself..."
                    
                    // speechRecognizer 2
                    self.speechRecognizer.reset()
                    self.speechRecognizer.transcribe()
                    // speechRecognizer 2 end
                    
                    self.main.recordingTimes += 1 // temporaryStorage_ObservableObject 4
                }
            }) {
                Image(self.main.isRecording ? "restart_alt_FILL0_wght400_GRAD0_opsz48" : "mic_FILL0_wght400_GRAD0_opsz48")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(ColorPalette.primaryThemeYellow.theme.accentColor)
                    .frame(width: 75.0, height: 75.0)
                    .padding()
                    .accessibilityLabel(self.main.isRecording ? "with transcription" : "without transcription")
            }
        }
        .background(RoundedRectangle(cornerRadius: 16.0)
            .fill(ColorPalette.primaryThemeYellow.theme.mainColor)
            .shadow(radius: 3)
        )
        .padding()
    }
}

//struct InputView_Previews: PreviewProvider {
//    static var previews: some View {
//        InputView()
//            .previewLayout(.fixed(width: 400, height: 350))
//    }
//}
