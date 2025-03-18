//
//  File.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 22/08/1446 AH.
//

import Foundation

// model used to structure the letters and retrive their details
struct MorseLettersModel: Identifiable {
    
    let id = UUID()
    let letter: String
    var word: String
    var imageName: String
    var morseCode: String
    var soundFile: String
    
}
