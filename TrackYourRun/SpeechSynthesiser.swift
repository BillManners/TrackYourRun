//
//  SpeechSynthesiser.swift
//  TrackYourRun
//
//  Created by Manners, William (Coll) on 07/11/2020.
//  Copyright © 2020 Manners, William (Coll). All rights reserved.
//

import Foundation
import AVFoundation

class SpeechSynthesiser {
    let synthesiser = AVSpeechSynthesizer()
    
    func Speak(textToSpeak: String) {
        let speechUtterance = AVSpeechUtterance(string: textToSpeak)
        
         
            speechUtterance.rate = 0.5
            speechUtterance.pitchMultiplier = 0.9
            speechUtterance.volume = 1
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-za")
         
        synthesiser.speak(speechUtterance)
    }
}
