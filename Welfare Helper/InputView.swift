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
    @State private var isRecording = false // speechRecognizer 4
    
    var body: some View {
        VStack {
            Text(speechRecognizer.transcript)
                .font(.headline)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center
                )
                .foregroundColor(Main.primaryThemeYellow.theme.accentColor)
                .padding()
            
            Button(action: {
                withAnimation(.easeInOut) { isRecording.toggle() }
                
                if !isRecording {
                    speechRecognizer.stopTranscribing() // speechRecognizer 3
                    isRecording = false // speechRecognizer 4
                } else {
                    // speechRecognizer 2
                    speechRecognizer.reset()
                    speechRecognizer.transcribe()
                    // speechRecognizer 2 end
                    isRecording = true // speechRecognizer 4
                }
            }) {
                Image(isRecording ? "restart_alt_FILL0_wght400_GRAD0_opsz48" : "mic_FILL0_wght400_GRAD0_opsz48")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Main.primaryThemeYellow.theme.accentColor)
                    .frame(width: 75.0, height: 75.0)
                    .padding()
                    .accessibilityLabel(isRecording ? "with transcription" : "without transcription")
            }
        }
        .background(RoundedRectangle(cornerRadius: 16.0)
            .fill(Main.primaryThemeYellow.theme.mainColor)
            .shadow(radius: 3)
        )
        .padding()
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
            .previewLayout(.fixed(width: 400, height: 350))
    }
}
