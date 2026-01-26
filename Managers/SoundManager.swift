//
//  SoundManager.swift
//  Morse Mission
//
//  Created by Shatha Almukhaild on 07/08/1447 AH.
//

import AVFoundation

class SoundManager {
    @MainActor static let shared = SoundManager()
    
    private var players: [String: AVAudioPlayer] = [:]
    
    func playSound(named soundName: String, type: String = "mp3") {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: type) else {
            print("Sound file not found: \(soundName).\(type)")
            return
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
            players[soundName] = player
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}
