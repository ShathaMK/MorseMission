//
//  File.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 23/08/1446 AH.
//
import AVFoundation

@MainActor
class MorseSoundPlayer {
    private var audioPlayer: AVAudioPlayer?

    init() {
        configureAudioSession()
    }

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("❌ Failed to set up audio session: \(error)")
        }
    }

    func playMorse(for text: String, speedMultiplier: Double = 1.0) {
        let characters = Array(text.uppercased())
        playNextLetter(in: characters, speedMultiplier: speedMultiplier)
    }

    private func playNextLetter(in characters: [Character], index: Int = 0, speedMultiplier: Double) {
        guard index < characters.count else { return } // Stop when finished

        let char = characters[index]
        let fileName = "\(char).mp3" // Expecting files named "A.mp3", "B.mp3", "1.mp3", etc.

        playSound(for: fileName)

        // Adjust delay between letters using the speed multiplier
        let delay = 0.5 / speedMultiplier
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.playNextLetter(in: characters, index: index + 1, speedMultiplier: speedMultiplier)
        }
    }

    private func playSound(for fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            print("❌ Sound file not found in bundle: \(fileName)")
            return
        }

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
            audioPlayer = player // keep strong reference so it isn't deallocated mid-playback
            print("✅ Playing: \(fileName)")
        } catch {
            print("❌ Error playing sound (\(fileName)): \(error)")
        }
    }
}
