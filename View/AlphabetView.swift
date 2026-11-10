//
//  File.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 22/08/1446 AH.

import SwiftUI

struct AlphabetView: View {
    @ObservedObject var viewModel = MorseLettersViewModel()
    @State private var showOnboarding = true
    @Environment(\.horizontalSizeClass) private var hSizeClass

    // Scaled values based on size class
    private var isCompact: Bool { hSizeClass == .compact }
    private var letterImageSize: CGFloat { isCompact ? 55 : 80 }
    private var letterImageHeight: CGFloat { isCompact ? 70 : 100 }
    private var morseBoxWidth: CGFloat { isCompact ? 80 : 120 }
    private var morseBoxHeight: CGFloat { isCompact ? 36 : 45 }
    private var morseFontSize: CGFloat { isCompact ? 32 : 55 }
    private var speakerButtonSize: CGFloat { isCompact ? 40 : 50 }
    private var speakerIconWidth: CGFloat { isCompact ? 24 : 35 }
    private var speakerIconHeight: CGFloat { isCompact ? 18 : 25 }

    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)

            List($viewModel.letters) { letter in
                VStack {
                    HStack {
                        Spacer()

                        HStack(spacing: isCompact ? 4 : 10) {
                            // Letter image + word
                            VStack {
                                Image(letter.imageName.wrappedValue)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: letterImageSize, height: letterImageHeight)
                                    .cornerRadius(10)

                                Text(letter.word.wrappedValue)
                                    .font(.system(isCompact ? .subheadline : .title, design: .rounded))
                                    .foregroundStyle(Color("FontColor"))
                                    .padding(.top, 5)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.7)
                            } // end of VStack (image + word)
                            .padding(.leading, isCompact ? 4 : 10)
                            .frame(maxWidth: .infinity, alignment: .leading)

                            // Morse Code Text
                            Text(letter.morseCode.wrappedValue)
                                .font(.system(size: morseFontSize, design: .rounded))
                                .foregroundStyle(Color("FontColor"))
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                                .frame(width: morseBoxWidth, height: morseBoxHeight, alignment: .bottom)
                                .background(Color("WhiteGrayColor").opacity(0.1))
                                .cornerRadius(15)
                                .padding(.horizontal, isCompact ? 4 : 10)

                            Spacer()

                            // Speaker Button
                            Button(action: {
                                viewModel.playSound(for: letter.soundFile.wrappedValue)
                            }) {
                                Image(systemName: "speaker.wave.3.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: speakerIconWidth, height: speakerIconHeight)
                                    .foregroundColor(Color("PurpleColor"))
                                    .padding(isCompact ? 8 : 11)
                                    .background(Color("WhiteGrayColor").opacity(0.1))
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                            } // end of Button
                            .contentShape(Rectangle())
                            .frame(width: speakerButtonSize, height: speakerButtonSize)
                            .padding(.trailing, isCompact ? 4 : 10)
 
                        } // end of HStack (row content)

                        Spacer()

                    } // end of HStack (outer row)
                } // end of VStack (row wrapper)
                .padding(.vertical, 5)
                .listRowBackground(Color("DarkGrayColor").opacity(0.5))
                .cornerRadius(20)
            } // end of List
            .scrollIndicators(.visible, axes: .vertical)
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollContentBackground(.hidden)
            .navigationTitle("Alphabet Letters")
            .navigationBarTitleDisplayMode(.large)
        } // end of ZStack
        .sheet(isPresented: $showOnboarding) {
            OnboardingView(showOnboarding: $showOnboarding)
                .navigationBarHidden(true)
        } // end of sheet
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear
            appearance.shadowColor = .clear
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color("FontColor"))]
            appearance.titleTextAttributes = [.foregroundColor: UIColor(Color("FontColor"))]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } // end of onAppear
    } // end of body
} // end of AlphabetView

struct OnboardingView: View {
    @Binding var showOnboarding: Bool

    var body: some View {
        ZStack{
    
            Color(.black).opacity(0.7)
                           .edgesIgnoringSafeArea(.all)
                       
        VStack(spacing: 20) {
            Spacer()
            Text("Timeless Communication")
                .font(.title)
                .foregroundStyle(Color("FontColor"))
                .bold()
            ScrollView{
                Text("Ever wondered how your phone talks to the world in an instant? It wasn't always this easy.\n\nBefore texts and calls, messages traveled by horse, ship, or bird. Slow and never guaranteed.\n\nThen in 1838, Samuel Morse changed everything with a code of dots (.) and dashes (-), the first form of electric communication. Slashes (/) mark the spaces between words.\n\nLearning it isn't just history. It sharpens memory and language processing faster than picking up a new spoken language.\n\nReady to unlock the skill? 🚀")
                    .foregroundStyle(Color("FontColor"))
                    .multilineTextAlignment(.center)
                    .padding()
            }
            Button("Get Started") {
                showOnboarding = false
            }
            .font(.headline)
            .padding()
            .background(Color("PurpleColor"))
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
    }
}


#Preview{
    AlphabetView()
}
