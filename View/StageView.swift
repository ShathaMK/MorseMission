//
//  File.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 25/08/1446 AH.
//import Foundation
import SwiftUI

struct StageView: View {
    @State private var isLandscape = false
    @State private var showQuestions = false
    @State private var currentAnswerTim1: String = ""
    @State private var currentAnswerTim2: String = ""

    // MARK: - PHONE: iPhone support (everything between here and `var body` is new)

    private let isPhone = UIDevice.current.userInterfaceIdiom == .phone // PHONE

    /// How big the UI is drawn on iPhone compared with iPad (0.6 = 60%).
    /// Lower = smaller UI / more of the scene visible. Higher = bigger text.
    private let phoneScale: CGFloat = 0.6 // PHONE

    /// Size of the iPad screen the artwork + Tim answer bubbles were designed on.
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

    private var hasAnswers: Bool { // PHONE
        !currentAnswerTim1.isEmpty || !currentAnswerTim2.isEmpty
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
                        Image("StageAllCharacters")
                            .resizable()
                            .frame(width: getScreenBounds().width, height: getScreenBounds().height)
                            .ignoresSafeArea()

                        uiLayer(canvas) // PHONE (your panels and buttons, moved into uiLayer below)

                        if showQuestions && hasAnswers { // PHONE (your Tim answers, moved into answerBubbles below)
                            answerBubbles
                        }
                    }
                    .navigationBarHidden(true)
                    .padding(.top, 10)
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
    ///  1. Art layer  = artwork + the two Tim answer bubbles, drawn at the iPad size and scaled to FILL the screen,
    ///                  so the bubbles always stay on the right characters.
    ///  2. UI layer   = your panels / buttons, drawn on a bigger canvas and shrunk to fit.
    private var phoneLandscape: some View { // PHONE
        GeometryReader { geo in
            let ins = geo.safeAreaInsets
            let fullW = geo.size.width + ins.leading + ins.trailing   // true screen size
            let fullH = geo.size.height + ins.top + ins.bottom

            let fill = max(fullW / artSize.width, fullH / artSize.height)  // art layer scale
            let s = min(phoneScale, fullW / 1194)                           // UI layer scale

            let canvas = DesignCanvas(
                size: CGSize(width: fullW / s, height: fullH / s),
                isPhone: true,
                inset: max(ins.leading, ins.trailing) / s,
                bottom: ins.bottom / s)

            ZStack(alignment: .topLeading) {
                // 1. Art layer
                artLayer
                    .frame(width: artSize.width, height: artSize.height)
                    .scaleEffect(fill)
                    .frame(width: fullW, height: fullH)
                    .clipped()

                // 2. UI layer
                uiLayer(canvas)
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

    @ViewBuilder
    private var artLayer: some View { // PHONE
        ZStack {
            Image("StageAllCharacters")
                .resizable()
                .frame(width: artSize.width, height: artSize.height)

            if showQuestions && hasAnswers {
                answerBubbles
            }
        }
    }

    // MARK: - Tim answer bubbles (your original code, moved here so iPad and iPhone share it)

    @ViewBuilder
    private var answerBubbles: some View { // PHONE (was inline in body)
        HStack(spacing: -10) {
            Spacer()
            HStack {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                VStack {
                    Text("Tim Cook 2")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(Color("FontColor"))
                        .padding(.trailing, 160)
                    ZStack(alignment: .leading) {
                        Text(currentAnswerTim1).opacity(0)
                        TypeWriterEffect(text: currentAnswerTim1)
                    }
                }
                .padding()
                .frame(width: 300, height: 100)
                .background(Color("DarkGrayColor"))
                .cornerRadius(15)
                .overlay(alignment: .bottomLeading) {
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.title)
                        .rotationEffect(.degrees(360))
                        .offset(x: 270, y: 17)
                        .foregroundStyle(Color("DarkGrayColor"))
                }
                .padding(.bottom, 400)
            }
            HStack {
                VStack {
                    Text("Tim Cook 1")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(Color("FontColor"))
                        .padding(.trailing, 160)
                    ZStack(alignment: .leading) {
                        Text(currentAnswerTim2).opacity(0)
                        TypeWriterEffect(text: currentAnswerTim2)
                    }
                }
                .padding()
                .frame(width: 300, height: 100)
                .background(Color("DarkGrayColor"))
                .cornerRadius(15)
                .overlay(alignment: .bottomLeading) {
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.title)
                        .rotationEffect(.degrees(360))
                        .offset(x: 10, y: 17)
                        .foregroundStyle(Color("DarkGrayColor"))
                }
                .padding(.bottom, 400)
                .padding(.leading, 50)
            }
            .padding(.trailing, 90)
            Spacer()
        }
    } // end of answerBubbles

    // MARK: - Panels and buttons (your original code, moved here so iPad and iPhone share it)

    @ViewBuilder
    private func uiLayer(_ L: DesignCanvas) -> some View { // PHONE (was inline in body)
        if !showQuestions {
            VStack {
                Rectangle()
                    .frame(width: L.size.width, height: 238) // PHONE: was getScreenBounds().width
                    .dialogueGlassEffect()
                    .ignoresSafeArea(edges: .top)
                    .overlay() {
                        ZStack {
                            Button(action: { showQuestions = true }) {
                                Spacer()
                                Image("Next")
                                    .resizable()
                                    .frame(width: 100, height: 40)
                            }
                            .padding()
                            .padding(.bottom, 120)

                            HStack {
                                HStack {
                                    Image("SparkProfile")
                                        .resizable()
                                        .frame(width: 140, height: 140)
                                        .padding(.trailing, 20)
                                    HStack {
                                        VStack {
                                            Text("Detective Spark")
                                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                                .foregroundColor(Color("FontColor"))
                                                .padding(.trailing, 120)
                                            ZStack(alignment: .leading) {
                                                Text("Two Tims? That can't be—something's off.").opacity(0)
                                                TypeWriterEffect(text: "Two Tims? That can't be—something's off.")
                                            }
                                            .padding(.leading, 9)
                                        }
                                        .padding()
                                        .frame(width: 330, height: 100)
                                    }
                                    .background(Color("PurpleColor"))
                                    .cornerRadius(15)
                                    .overlay(alignment: .bottomLeading) {
                                        Image(systemName: "arrowtriangle.down.fill")
                                            .font(.title)
                                            .rotationEffect(.degrees(90))
                                            .offset(x: -15, y: -10)
                                            .foregroundStyle(Color("PurpleColor"))
                                    }
                                }
                                Spacer()
                            }.padding()
                            .padding(.horizontal, L.inset) // PHONE

                            HStack {
                                Spacer()
                                HStack {
                                    VStack {
                                        Text("Detective Flash")
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                            .foregroundColor(Color("FontColor"))
                                            .padding(.trailing, 100)
                                        ZStack(alignment: .leading) {
                                            Text("Agreed. Let's get some answers.").opacity(0)
                                            TypeWriterEffect(text: "Agreed. Let's get some answers.")
                                        }
                                    }
                                    .padding()
                                    .frame(width: 330, height: 100)
                                }
                                .background(Color("DarkGrayColor"))
                                .cornerRadius(15)
                                .overlay(alignment: .bottomLeading) {
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .font(.title)
                                        .rotationEffect(.degrees(-90))
                                        .offset(x: 320, y: -10)
                                        .foregroundStyle(Color("DarkGrayColor"))
                                }
                                Image("FlashProfile")
                                    .resizable()
                                    .frame(width: 140, height: 140)
                                    .padding(.leading, 20)
                            }
                            .padding(.top, 90)
                            .padding()
                            .padding(.horizontal, L.inset) // PHONE
                        }
                    }
                    // PHONE: iPad keeps your 600. On iPhone the canvas is shorter, so no extra push (it would move the panel off-screen).
                    .padding(.bottom, L.isPhone ? 0 : 600)
                Spacer()
            }
        } else {
            VStack {
                Spacer()
                Rectangle()
                    .frame(width: L.size.width, height: 238) // PHONE: was getScreenBounds().width
                    .dialogueGlassEffect()
                    .overlay() {
                        VStack(spacing: -50) {
                            HStack(alignment: .center, spacing: 50) {
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Text("Who is the real Tim Cook ?")
                                    .font(.system(size: 40, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("FontColor"))
                                Spacer()
                                Spacer()
                                NavigationLink(destination: VotingView()) {
                                    ZStack {
                                        Rectangle()
                                            .foregroundStyle(Color("YellowColor")).opacity(0.9)
                                            .frame(width: 120, height: 50)
                                            .cornerRadius(15)
                                        Text("Vote")
                                            .font(.system(size: 30, weight: .bold, design: .rounded))
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding()
                                Spacer()
                            }

                            Spacer()

                            HStack(spacing: 20) {
                                Spacer()
                                Button(action: {
                                    currentAnswerTim1 = ""
                                    currentAnswerTim2 = ""
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                        currentAnswerTim1 = "I was backstage, preparing my keynote presentation."
                                        currentAnswerTim2 = "I was rehearsing in the main hall."
                                    }
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .foregroundStyle(Color("PurpleColor"))
                                            .frame(width: 420, height: 50)
                                            .cornerRadius(15)
                                        Text("Where were you before coming on stage?")
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                            .foregroundColor(Color("FontColor"))
                                    }
                                }
                                Button(action: {
                                    currentAnswerTim1 = ""
                                    currentAnswerTim2 = ""
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                        currentAnswerTim1 = "We're bringing back the flip phone era that's all I can say for now."
                                        currentAnswerTim2 = "We're launching a toaster. That's all I can say for now. "
                                    }
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .foregroundStyle(Color("PurpleColor"))
                                            .frame(width: 300, height: 50)
                                            .cornerRadius(15)
                                        Text("What's the big surprise today ?")
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                            .foregroundColor(Color("FontColor"))
                                    }
                                }
                                Button(action: {
                                    currentAnswerTim1 = ""
                                    currentAnswerTim2 = ""
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                        currentAnswerTim1 = "I heard people lined up outside since 5 AM. Dedication."
                                        currentAnswerTim2 = "Pretty empty, honestly. Maybe ten people showed up."
                                    }
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .foregroundStyle(Color("PurpleColor"))
                                            .frame(width: 300, height: 50)
                                            .cornerRadius(15)
                                        Text("How's the crowd today?")
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                            .foregroundColor(Color("FontColor"))
                                    }
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                        .padding(.horizontal, L.inset) // PHONE
                    }
            }
        }
    } // end of uiLayer
}

struct StageView_previews: PreviewProvider {
    static var previews: some View {
        StageView()
    }
}
