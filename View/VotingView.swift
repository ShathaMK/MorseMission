//
//  File.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 22/08/1446 AH.

import SwiftUI

struct VotingView: View {
    @State private var isLandscape = false
    @State private var isSelected = false
    @State private var isSelected2 = false
    @State private var revealText = ""
    @State private var win = false
    @State private var lose = false

    var body: some View {
        ZStack {
            if isLandscape {
                ZStack {
                    Image("StageTwoTims")
                        .resizable()
                        .ignoresSafeArea()
                        .overlay {
                            if win {
                                Color("PurpleColor").opacity(0.6).ignoresSafeArea()
                                VStack(spacing: 50) {
                                    Image("Win").resizable().frame(width: 600, height: 200)
                                    Text(revealText)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                        .foregroundColor(Color("FontColor"))
                                    NavigationLink(destination: MainView()) {
                                        ZStack {
                                            Rectangle()
                                                .foregroundStyle(Color("PurpleColor")).opacity(0.9)
                                                .frame(width: 150, height: 50)
                                                .cornerRadius(15)
                                            Text("Return")
                                                .font(.system(size: 30, weight: .bold, design: .rounded))
                                                .foregroundColor(Color("FontColor"))
                                        }
                                    }
                                }
                            } else if lose {
                                Color.red.opacity(0.3).ignoresSafeArea()
                                VStack(spacing: 50) {
                                    Image("Lose").resizable().frame(width: 500, height: 200)
                                    Text(revealText)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                        .foregroundColor(Color("FontColor"))
                                    NavigationLink(destination: MainView()) {
                                        ZStack {
                                            Rectangle()
                                                .foregroundStyle(Color.red).opacity(0.9)
                                                .frame(width: 150, height: 50)
                                                .cornerRadius(15)
                                            Text("Return")
                                                .font(.system(size: 30, weight: .bold, design: .rounded))
                                                .foregroundColor(Color("FontColor"))
                                        }
                                    }
                                }
                            }
                        }

                    if !win && !lose {
                        VStack {
                            Spacer()
                            Rectangle()
                                .frame(width: getScreenBounds().width, height: 238)
                                .dialogueGlassEffect()
                                .overlay {
                                    VStack(spacing: -30) {
                                        Spacer()
                                        HStack(alignment: .center, spacing: 50) {
                                            Spacer()
                                            Text("Who is the real Tim Cook?")
                                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                                .foregroundColor(Color("FontColor"))
                                            Spacer()
                                        }
                                        Spacer()
                                        HStack(spacing: 20) {
                                            Spacer()
                                            Button(action: {
                                                isSelected.toggle()
                                                if isSelected { isSelected2 = false }
                                                checkAnswer()
                                            }) {
                                                SelectButton(isSelected: $isSelected,
                                                             color: Color("PurpleColor"),
                                                             text: "Tim cook 1")
                                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                            }
                                            Button(action: {
                                                isSelected2.toggle()
                                                if isSelected2 { isSelected = false }
                                                checkAnswer()
                                            }) {
                                                SelectButton(isSelected: $isSelected2,
                                                             color: .red,
                                                             text: "Tim cook 2")
                                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                            }
                                            Spacer()
                                        }
                                        Spacer()
                                        Spacer()
                                    }
                                }
                        }
                        .padding(.top, 10)
                    }
                }
                .navigationBarHidden(true)

            } else {
                PortraitPrompt()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            let newOrientation = UIDevice.current.orientation
            if newOrientation == .faceUp || newOrientation == .faceDown || newOrientation == .unknown { return }
            if newOrientation == .landscapeLeft || newOrientation == .landscapeRight {
                isLandscape = true
            } else if newOrientation == .portrait || newOrientation == .portraitUpsideDown {
                isLandscape = false
            }
        }
        .onAppear {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                isLandscape = scene.interfaceOrientation.isLandscape
            }
        }
        .onDisappear {
            SoundManager.shared.stopAllSounds()
        }
    }

    private func checkAnswer() {
        if isSelected {
            SoundManager.shared.playSound(named: "Alphabet")
            revealText = "You caught the spy and saved the event 🚀"
            win = true
        } else {
            SoundManager.shared.playSound(named: "SOS")
            revealText = "Hard luck, Please try again 😞."
            lose = true
        }
    }
}

struct VotingView_previews: PreviewProvider {
    static var previews: some View {
        VotingView()
    }
}
