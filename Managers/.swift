//
//  SoundManager 2.swift
//  Morse Mission
//
//  Created by Shatha Almukhaild on 23/09/1447 AH.
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
    
    // ADD THESE METHODS
    func stopSound(named soundName: String) {
        players[soundName]?.stop()
        players[soundName] = nil
    }
    
    func stopAllSounds() {
        players.values.forEach { $0.stop() }
        players.removeAll()
    }
}
