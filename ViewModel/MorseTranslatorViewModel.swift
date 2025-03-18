//
//  File.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 22/08/1446 AH.
//

import Foundation
import SwiftUI
@MainActor

class MorseTranslatorViewModel: ObservableObject {
    @Published var morseText:String = ""
    @Published var englishText:String = ""
    
    
    //Morse Code Dictionary for decoding
    private let morseCodeDictionary: [String: String] = [
        ".-":"A",
        "-...":"B",
        "-.-.":"C",
        "-..":"D",
        ".":"E",
        "..-.":"F",
        "--.":"G",
        "....":"H",
        "..":"I",
        ".---":"J",
        "-.-":"K",
        ".-..":"L",
        "--":"M",
        "-.":"N",
        "---":"O",
        ".--.":"P",
        "--.-":"Q",
        ".-.":"R",
        "...":"S",
        "-":"T",
        "..-":"U",
        "...-":"V",
        ".--":"W",
        "-..-":"X",
        "-.--":"Y",
        "--..":"Z",
        ".----":"1",
        "..---":"2",
        "...--":"3",
        "....-":"4",
        ".....":"5",
        "-....":"6",
        "--...":"7",
        "---..":"8",
        "----.":"9",
        "-----":"0",
        "/":" "
    ]
    
    private let englishToMorse: [String: String]
    let soundPlayer = MorseSoundPlayer() // Use the new sound player class

    init() {
        // reverse the dicitionary for Encoding
        self.englishToMorse = Dictionary(uniqueKeysWithValues: morseCodeDictionary.map { ($1,$0) })
        
    }
    
    
    func decodeMorseCode(){
        
        let words = morseText.split(separator: " / ")
        let decodedWords = words.map { word in word.split(separator: " ").compactMap { morseCodeDictionary [String($0)]}.joined()
        }
        englishText = decodedWords.joined(separator: " ")
    }
    
    func encodeEnglishText(){
        let words = englishText.uppercased().split(separator: " ")
        let encodedWords = words.map { word in
        word.map { englishToMorse [String($0)] ?? "" }.joined(separator: " ")
    }
        
    morseText = encodedWords.joined(separator: " / ")
    
}
    
    // Function to play the translated message
    func playTranslation() {
        let textToPlay = englishText.isEmpty ? morseText : englishText
        soundPlayer.playMorse(for: textToPlay)
    }
}
    
    
    


