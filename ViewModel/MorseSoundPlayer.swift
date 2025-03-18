//
//  File.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 23/08/1446 AH.
//
import AVFoundation
@MainActor

class MorseSoundPlayer {
    var audioPlayer: AVAudioPlayer?

    func playMorse(for text: String, speedMultiplier: Double = 1.0) {
        let characters = Array(text.uppercased()) // Convert text to uppercase letters
        playNextLetter(in: characters, speedMultiplier: speedMultiplier)
    }

    private func playNextLetter(in characters: [Character], index: Int = 0, speedMultiplier: Double) {
        guard index < characters.count else { return } // Stop when finished

        let char = characters[index]
        let fileName = "\(char).mp3" // Assuming sounds are named like "A.mp3", "B.mp3"

        if let _ = Bundle.main.url(forResource: fileName, withExtension: nil) {
            playSound(for: fileName)
        }

        // Adjust delay between letters using the speed multiplier
        let delay = 0.5 / speedMultiplier // Default speed is 0.5 seconds between characters
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.playNextLetter(in: characters, index: index + 1, speedMultiplier: speedMultiplier)
        }
    }

    private func playSound(for fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            print("❌ Sound file not found: \(fileName)")
            return
        }
        print("✅ Playing: \(fileName)")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("❌ Error playing sound: \(error.localizedDescription)")
        }
    }
}
