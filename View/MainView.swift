//
//  MainPage.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 21/08/1446 AH.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = GameViewModel()
    @State private var isLandscape = false

    
    var body: some View {
        ZStack{
            NavigationStack{
                ZStack {
                    Color("BackgroundColor").ignoresSafeArea()
                    
                    if isLandscape{
                        // Landscape - layout with dialogue
                        VStack(spacing: 60) {
                            HStack{
                                Image("SparkProfile").resizable().frame(width: 180, height: 180)
                                
                                // Dialogue Box for Landscape
                                DialogueBox(
                                    title: "Hello Detective 🕵️‍♂️",
                                    text: "Your mission: master Morse code to crack the case. Dots and dashes will help you uncover hidden messages and catch the imposter lurking in the shadows.\nThe fate of WWDC25 is in your hands. Are you ready to begin? 🔍"
                                )

                                    .frame(width: 805, height: 200)
                            }
                            
                            HStack(spacing:120) {
                                Spacer()
                                NavigationLink(destination: AlphabetView()){
                                    Image("Level1").resizable().frame(width: 250,height: 450)
                                }
                                NavigationLink(destination: TranslatorView()){
                                    Image("Level3").resizable().frame(width: 250,height: 450)
                                }
                                NavigationLink(destination: FindSpyView(viewModel:viewModel)){
                                    Image("Level2").resizable().frame(width: 250,height: 450)
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                    } else {
                        // Portrait - vertical stack
                        ScrollView {
                            VStack(spacing: 50) {
                                HStack(spacing: 10) {
                                    Spacer()
                                    Image("SparkProfile")
                                        .resizable()
                                        .frame(width: 200, height: 200)
                                    
                                    // Dialogue Box for Portrait
                                    DialogueBox(
                                        title: "Hello Detective 🕵️‍♂️",
                                        text: "Your mission: master Morse code to crack the case. Dots and dashes will help you uncover hidden messages and catch the imposter lurking in the shadows.The fate of WWDC25 is in your hands. Are you ready to begin? 🔍"
                                    )

                                        .frame(maxWidth: 500, maxHeight: 400)
                                    Spacer()
                                }
                                .padding(.top, 60)
                                
                                LazyVGrid(columns: [
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                ], spacing: 80) {
                                    NavigationLink(destination: AlphabetView()){
                                        Image("Level1")
                                            .resizable()
                                            .frame(width: 280, height: 400)
                                    }
                                    
                                    NavigationLink(destination: TranslatorView()){
                                        Image("Level3")
                                            .resizable()
                                            .frame(width: 280, height: 400)
                                    }
                                    
                                    NavigationLink(destination: FindSpyView(viewModel: viewModel)){
                                        Image("Level2")
                                            .resizable()
                                            .frame(width: 280, height: 400)
                                    }
                                }
                                .padding(.horizontal, 20)                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
            .accentColor(Color("PurpleColor"))
            .navigationBarHidden(true)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            let newOrientation = UIDevice.current.orientation
            
            // IGNORE flat positions - keep current state
            if newOrientation == .faceUp || newOrientation == .faceDown || newOrientation == .unknown {
                return
            }
            
            // Only update for valid rotations
            if newOrientation == .landscapeLeft || newOrientation == .landscapeRight {
                isLandscape = true
            } else if newOrientation == .portrait || newOrientation == .portraitUpsideDown {
                isLandscape = false
            }
        }
        .onAppear {
            // Check initial orientation from interface
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                isLandscape = scene.interfaceOrientation.isLandscape
            }
        }
    }
}

// Dialogue Box Component - with speech bubble arrow
// Dialogue Box Component
struct DialogueBox: View {
    let title: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            // Speech bubble tail/arrow pointing left
            SpeechBubbleTail()
                .fill(Color("DarkGrayColor"))
                .frame(width: 25, height: 40)
                .offset(x: 5, y: 75)
            
            // Main dialogue box
            VStack(alignment: .leading, spacing: 8) {
                // Title - bold
                Text(title)
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                // Body text - regular
                Text(text)
                    .font(.system(size: 17, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .lineSpacing(5)
            }
            .multilineTextAlignment(.leading)
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("DarkGrayColor"))
            )
        }
    }
}

// Speech bubble tail shape - triangle pointing left
struct SpeechBubbleTail: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()
        return path
    }
}
