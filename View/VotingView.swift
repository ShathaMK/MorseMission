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

    // MARK: - PHONE: iPhone support (everything between here and `var body` is new)

    private let isPhone = UIDevice.current.userInterfaceIdiom == .phone // PHONE

    /// How big the UI is drawn on iPhone compared with iPad (0.6 = 60%).
    /// Lower = smaller UI / more of the scene visible. Higher = bigger text.
    private let phoneScale: CGFloat = 0.6 // PHONE

    /// Size of the iPad screen the artwork was designed on (same value as StageView,
    /// so the background looks identical when moving from Stage to Voting).
    private let artSize = CGSize(width: 1194, height: 834) // PHONE

    /// The "design canvas" your layout is drawn on.
    /// iPad: the real screen, no extra insets -> your original layout.
    /// iPhone: a bigger virtual screen that is scaled down to fit.
    private struct DesignCanvas { // PHONE
        let size: CGSize      // canvas size in design points
        let isPhone: Bool
        let inset: CGFloat    // side padding so UI stays clear of the notch / Dynamic Island
        let bottom: CGFloat   // home-indicator clearance
    }

    var body: some View {
        ZStack {
            if isLandscape {
                if isPhone { // PHONE
                    phoneLandscape // PHONE
                } else { // PHONE
                    // iPad - your original layout, unchanged
                    let canvas = DesignCanvas( // PHONE
                        size: CGSize(width: getScreenBounds().width, height: getScreenBounds().height),
                        isPhone: false, inset: 0, bottom: 0)

                    ZStack {
                        Image("StageTwoTims")
                            .resizable()
                            .ignoresSafeArea()
                            .overlay {
                                resultOverlay(canvas) // PHONE (your win / lose screens, moved into resultOverlay below)
                            }

                        if !win && !lose {
                            votePanel(canvas) // PHONE (your voting panel, moved into votePanel below)
                        }
                    }
                    .navigationBarHidden(true)
                } // PHONE

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

    // MARK: - PHONE: iPhone wrapper

    /// Two layers:
    ///  1. Artwork, drawn at the iPad size and scaled to FILL the screen (same as StageView).
    ///  2. UI (win / lose screen or the voting panel), drawn on a bigger canvas and shrunk to fit.
    private var phoneLandscape: some View { // PHONE
        GeometryReader { geo in
            let ins = geo.safeAreaInsets
            let fullW = geo.size.width + ins.leading + ins.trailing   // true screen size
            let fullH = geo.size.height + ins.top + ins.bottom

            let fill = max(fullW / artSize.width, fullH / artSize.height)  // artwork scale
            let s = min(phoneScale, fullW / 1194)                           // UI scale

            let canvas = DesignCanvas(
                size: CGSize(width: fullW / s, height: fullH / s),
                isPhone: true,
                inset: max(ins.leading, ins.trailing) / s,
                bottom: ins.bottom / s)

            ZStack(alignment: .topLeading) {
                // 1. Artwork
                Image("StageTwoTims")
                    .resizable()
                    .frame(width: artSize.width, height: artSize.height)
                    .scaleEffect(fill)
                    .frame(width: fullW, height: fullH)
                    .clipped()

                // 2. UI
                ZStack {
                    resultOverlay(canvas)

                    if !win && !lose {
                        votePanel(canvas)
                    }
                }
                .frame(width: canvas.size.width, height: canvas.size.height)
                .scaleEffect(s, anchor: .topLeading)
                .frame(width: fullW, height: fullH, alignment: .topLeading)
            }
            .frame(width: fullW, height: fullH, alignment: .topLeading)
            .offset(x: -ins.leading, y: -ins.top)
        } // end of GeometryReader
        .navigationBarHidden(true)
        .background(Color.black.ignoresSafeArea())
    } // end of phoneLandscape

    // MARK: - PHONE: full-screen tint

    /// iPad keeps your original .ignoresSafeArea(); on iPhone the canvas already covers the whole screen.
    @ViewBuilder
    private func dim(_ color: Color, _ L: DesignCanvas) -> some View { // PHONE
        if L.isPhone {
            color
        } else {
            color.ignoresSafeArea()
        }
    }

    // MARK: - Win / lose screens (your original code, moved here so iPad and iPhone share it)

    @ViewBuilder
    private func resultOverlay(_ L: DesignCanvas) -> some View { // PHONE (was inline in body)
        if win {
            dim(Color("PurpleColor").opacity(0.6), L) // PHONE: was Color("PurpleColor").opacity(0.6).ignoresSafeArea()
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
            dim(Color.red.opacity(0.3), L) // PHONE: was Color.red.opacity(0.3).ignoresSafeArea()
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
    } // end of resultOverlay

    // MARK: - Voting panel (your original code, moved here so iPad and iPhone share it)

    @ViewBuilder
    private func votePanel(_ L: DesignCanvas) -> some View { // PHONE (was inline in body)
        VStack {
            Spacer()
            Rectangle()
                .frame(width: L.size.width, height: 238) // PHONE: was getScreenBounds().width
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
                                isSelected2.toggle()
                                if isSelected2 { isSelected = false }
                                checkAnswer()
                               
                            }) {
                                SelectButton(isSelected: $isSelected,
                                             color: Color("PurpleColor"),
                                             text: "Tim cook 1")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            }
                            Button(action: {
                                isSelected.toggle()
                                if isSelected { isSelected2 = false }
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
                    .padding(.horizontal, L.inset) // PHONE
                }
        }
        .padding(.top, 10)
    } // end of votePanel

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
