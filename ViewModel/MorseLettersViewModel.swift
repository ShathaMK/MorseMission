//
//  File.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 22/08/1446 AH.
//


// Used Av Foundation library to play morse code letters sounds
import AVFoundation



class MorseLettersViewModel: ObservableObject {
    
    @Published var letters: [MorseLettersModel] = [
        MorseLettersModel (letter: "A", word: "Apple", imageName: "A_", morseCode: ".-", soundFile: "A.mp3"),
        MorseLettersModel (letter: "B", word: "Bango", imageName: "B_", morseCode: "-...", soundFile: "B.mp3"),
        MorseLettersModel (letter: "C", word: "Cat", imageName: "C_", morseCode: "-.-.", soundFile: "C.mp3"),
        MorseLettersModel (letter: "D", word: "Dog",imageName: "D_",morseCode: "-..", soundFile: "D.mp3"),
        MorseLettersModel (letter: "E", word: "Eye",imageName: "E_",morseCode: ".", soundFile: "E.mp3"),
        MorseLettersModel (letter: "F", word:" Firetruck", imageName: "F_",morseCode: "..-.", soundFile: "F.mp3"),
        MorseLettersModel (letter: "G", word: "Giraffe", imageName: "G_", morseCode: "--.", soundFile: "G.mp3"),
        MorseLettersModel (letter: "H", word: "Hippo", imageName: "H_", morseCode: "....", soundFile: "H.mp3"),
        MorseLettersModel (letter: "I", word: "Iphone", imageName: "I_", morseCode: "..", soundFile: "I.mp3"),
        MorseLettersModel (letter: "J", word: "Jellyfish", imageName: "J_", morseCode: ".---", soundFile: "J.mp3"),
        MorseLettersModel (letter: "K", word: "Kite", imageName: "K_", morseCode: "-.-", soundFile: "K.mp3"),
        MorseLettersModel (letter: "L", word: "Laboratory", imageName: "L_", morseCode: ".-..", soundFile: "L.mp3"),
        MorseLettersModel (letter: "M", word: "Mustache", imageName: "M_", morseCode: "--", soundFile: "M.mp3"),
        MorseLettersModel (letter: "N", word: "Net", imageName: "N_", morseCode: "-.", soundFile: "N.mp3"),
        MorseLettersModel (letter: "O", word: "Orachestra", imageName: "O_", morseCode: "---", soundFile: "O.mp3"),
        MorseLettersModel (letter: "P", word: "Paddles", imageName: "P_", morseCode: ".--.", soundFile: "P.mp3"),
        MorseLettersModel (letter: "Q", word: "Quarterback", imageName: "Q_", morseCode: "--.-", soundFile: "Q.mp3"),
        MorseLettersModel (letter: "R", word: "Robot", imageName: "R_", morseCode: ".-.", soundFile: "R.mp3"),
        MorseLettersModel (letter: "T", word: "Tape", imageName: "T_", morseCode: "-", soundFile: "T.mp3"),
        MorseLettersModel (letter: "U", word: "Unicorn", imageName: "U_", morseCode: "..-", soundFile: "U.mp3"),
        MorseLettersModel (letter: "V", word: "Vacuum", imageName: "V_", morseCode: "...-", soundFile: "V.mp3"),
        MorseLettersModel (letter: "W", word: "Wand", imageName: "W_", morseCode: ".--", soundFile: "W.mp3"),
        MorseLettersModel (letter: "X", word: "X-ray", imageName: "X_", morseCode: "-..-", soundFile: "X.mp3"),
        MorseLettersModel (letter: "Y", word: "Yard", imageName: "Y_", morseCode: "-.--", soundFile: "Y.mp3"),
        MorseLettersModel (letter: "Z", word: "Zebra", imageName: "Z_", morseCode: "--..", soundFile: "Z.mp3"),
        ]

    var audioPlayer: AVAudioPlayer?

// function to play sounds in the resources (Morse Alphabet)
    func playSound(for fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            print("❌ Sound file not found: \(fileName)")
            return
        }
        print("✅ Sound file found at: \(url)")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("❌ Error playing sound: \(error.localizedDescription)")
        }
    }
    



    }





    

