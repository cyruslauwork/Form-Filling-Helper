//
//  SpeechRecognizer.swift
//  TEST App
//
//  Created by someone on 17/5/2022.
//

// * speechRecognizer

import Foundation
import AVFoundation
import Speech

class SpeechRecognizer: ObservableObject {
    
    // speechRecognizer 2
    enum RecognizerError: Error {
        case nilRecognizer
        case notAuthorizedToRecognize
        case notPermittedToRecord
        case recognizerIsUnavailable
        
        var message: String {
            switch self {
            case .nilRecognizer: return "Can't initialize speech recognizer"
            case .notAuthorizedToRecognize: return "Not authorized to recognize speech"
            case .notPermittedToRecord: return "Not permitted to record audio"
            case .recognizerIsUnavailable: return "Recognizer is unavailable"
            }
        }
    }
    
    @Published var transcript: String = ""
    
    private var audioEngine: AVAudioEngine?
    private var request:  SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private var recognizer: SFSpeechRecognizer?
    
    init() {
        recognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
//        print(SFSpeechRecognizer.supportedLocales())
//        [es-419 (fixed), th-TH (fixed), ca-ES (fixed), fr-BE (fixed), de-CH (fixed), sk-SK (fixed), en-ZA (fixed), es-CL (fixed), hi-IN (fixed), zh-CN (fixed), zh-TW (fixed), da-DK (fixed), hi-IN-translit (fixed), el-GR (fixed), he-IL (fixed), pt-BR (fixed), en-AE (fixed), pt-PT (fixed), fr-CH (fixed), ro-RO (fixed), vi-VN (fixed), en-SA (fixed), pl-PL (fixed), es-US (fixed), hi-Latn (fixed), en-SG (fixed), tr-TR (fixed), hr-HR (fixed), ko-KR (fixed), uk-UA (fixed), it-CH (fixed), ar-SA (fixed), id-ID (fixed), en-IN (fixed), es-ES (fixed), de-AT (fixed), en-IE (fixed), cs-CZ (fixed), es-CO (fixed), zh-HK (fixed), sv-SE (fixed), en-PH (fixed), en-ID (fixed), en-CA (fixed), nl-NL (fixed), yue-CN (fixed), en-NZ (fixed), en-GB (fixed), ja-JP (fixed), it-IT (fixed), ru-RU (fixed), en-US (fixed), ms-MY (fixed), es-MX (fixed), hu-HU (fixed), fr-CA (fixed), wuu-CN (fixed), de-DE (fixed), fr-FR (fixed), fi-FI (fixed), nb-NO (fixed), nl-BE (fixed), en-AU (fixed)]
        
        Task(priority: .background) {
            do {
                guard recognizer != nil else {
                    throw RecognizerError.nilRecognizer
                }
                
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    throw RecognizerError.notAuthorizedToRecognize
                }
                
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    throw RecognizerError.notPermittedToRecord
                }
            } catch {
                speakError(error)
            }
        }
    }
    // speechRecognizer 2 end
    
    // speechRecognizer 7
    deinit {
        reset()
    }
    // speechRecognizer 7 end
    
    // speechRecognizer 8
    func transcribe() {
        DispatchQueue(label: "Speech Recognizer Queue", qos: .background).async { [weak self] in
            guard let self = self, let recognizer = self.recognizer, recognizer.isAvailable else {
                self?.speakError(RecognizerError.recognizerIsUnavailable)
                return
            }
            
            do {
                let (audioEngine, request) = try Self.prepareEngine()
                self.audioEngine = audioEngine
                self.request = request
                self.task = recognizer.recognitionTask(with: request, resultHandler: self.recognitionHandler(result:error:))
            } catch {
                self.reset()
                self.speakError(error)
            }
        }
    }
    
    func stopTranscribing() {
        reset()
    }
    // speechRecognizer 8 end
    
    // speechRecognizer 6
    func reset() {
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }
    // speechRecognizer 6 end
    
    // speechRecognizer 9
    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            request.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()
        
        return(audioEngine, request)
    }
    // speechRecognizer 9 end
    
    // speechRecognizer 5
    private func recognitionHandler(result: SFSpeechRecognitionResult?, error: Error?) {
        let receivedFinalResult = result?.isFinal ?? false
        let receivedError = error != nil
        
        if receivedFinalResult || receivedError {
            audioEngine?.stop()
            audioEngine?.inputNode.removeTap(onBus: 0)
        }
        
        if let result = result {
            speak(result.bestTranscription.formattedString)
        }
    }
    // speechRecognizer 5 end
    
    // speechRecognizer 4
    private func speak(_ message: String) {
        transcript = message
    }
    
    private func speakError(_ error: Error) {
        var errorMessage = ""
        if let error = error as? RecognizerError {
            errorMessage += error.message
        } else {
            errorMessage += error.localizedDescription
        }
        transcript = "<< \(errorMessage) >>"
    }
    // speechRecognizer 4 end
}

// speechRecognizer 3
extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}

extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            requestRecordPermission { authorized in
                continuation.resume(returning: authorized) // ".resume()" loop "continuation" again, "returning: authorized" jump to afore-mentioned "-> Bool"
            }
        }
    }
}
// speechRecognizer 3 end

