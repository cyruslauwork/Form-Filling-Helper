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
    @State var isRecording: Bool = false // speechRecognizer 4
    @StateObject var main: Main // temporaryStorage_ObservableObject 5
    
    @State var Transcription: String = "Briefly introduce yourself and see the welfares that suit you" // speechRecognizer 4
    let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect() // Timer
    
    var body: some View {
        VStack {
            Text(Transcription) // speechRecognizer 6
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
                .onReceive(timer) { time in
                    // Make View update automatically
                    if isRecording {
                        Transcription = speechRecognizer.transcript // speechRecognizer 5
                    }
                }
                // Timer 2 end
            
            Button(action: {
                withAnimation(.easeInOut) { isRecording.toggle() }
                
                if !isRecording {
                    speechRecognizer.stopTranscribing() // speechRecognizer 3
                } else {
                    // speechRecognizer 2
                    speechRecognizer.reset()
                    speechRecognizer.transcribe()
                    // speechRecognizer 2 end
                    main.recordingTimes += 1 // temporaryStorage_ObservableObject 5
                }
            }) {
                Image(isRecording ? "restart_alt_FILL0_wght400_GRAD0_opsz48" : "mic_FILL0_wght400_GRAD0_opsz48")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(ColorPalette.primaryThemeYellow.theme.accentColor)
                    .frame(width: 75.0, height: 75.0)
                    .padding()
                    .accessibilityLabel(isRecording ? "with transcription" : "without transcription")
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
