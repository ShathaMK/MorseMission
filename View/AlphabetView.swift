//
//  File.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 22/08/1446 AH.

import SwiftUI

struct AlphabetView: View {
    @ObservedObject var viewModel = MorseLettersViewModel()
    @State private var showOnboarding = true  // Show onboarding by default

    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            
            List($viewModel.letters) { letter in
                VStack {
                    HStack {
                        // Image and Morse Code Column
                        VStack {
                            Image(letter.imageName.wrappedValue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 100)
                                .cornerRadius(10)
                            
                            Text(letter.word.wrappedValue)
                                .font(.system(.title, design: .rounded))
                                .foregroundStyle(Color("FontColor"))
                                .padding(.top, 5)
                        }
                        .padding(.leading, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                       
                        // Morse Code Text
                        Text(letter.morseCode.wrappedValue)
                            .font(.system(size: 55, design: .rounded))
                            .foregroundStyle(Color("FontColor"))
                            .frame(width: 120, height: 45, alignment: .bottom)
                            .background(Color("WhiteGrayColor").opacity(0.1))
                            .cornerRadius(15)
                            .padding(.horizontal, 10)
                        
                        Spacer()
                        
                        // Speaker Button
                        Button(action: {
                            viewModel.playSound(for: letter.soundFile.wrappedValue)
                        }) {
                            Image(systemName: "speaker.wave.3.fill")
                                .resizable()
                                .frame(width: 35, height: 25)
                                .foregroundColor(Color("PurpleColor"))
                                .padding(11)
                                .background(Color("WhiteGrayColor").opacity(0.1))
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }
                        .contentShape(Rectangle())
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 10)
                    }
                    Divider()
                        .background(Color("WhiteGrayColor")).opacity(0.3)
                        .frame(width: 730, height: 1)
                        .padding(.vertical, 5)
                }
                .padding(.vertical, 5)
                .listRowBackground(Color("DarkGrayColor").opacity(0.5))
                .cornerRadius(20)
            }
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollContentBackground(.hidden)
        }
        .sheet(isPresented: $showOnboarding) {
            OnboardingView(showOnboarding: $showOnboarding)
                .navigationBarHidden(true)
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear
            appearance.shadowColor = .clear

            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }

    }
}

struct OnboardingView: View {
    @Binding var showOnboarding: Bool

    var body: some View {
        ZStack{
    
            Color(.black).opacity(0.7)
                           .edgesIgnoringSafeArea(.all)
                       
        VStack(spacing: 20) {
            Text("Timeless Communication")
                .font(.largeTitle)
                .foregroundStyle(Color("FontColor"))
                .bold()
            ScrollView{
                Text("Have you ever wondered how we communicate with our phones, even across vast distances? Before texts and calls, how did people stay connected? \n \nLong ago, messages traveled by horses, ships, or even birds, but these methods had limitations in speed and distance.\n\nThat changed in 1838 when Samuel Morse invented Morse code, the first form of electric communication—a system of dots (.) and dashes (-) used to represent letters and words. To form sentences, slashes (/) indicate spaces between words.\n\nBeyond its historical importance, learning Morse code enhances brain function by strengthening language processing and memory skills—but in a much shorter time than learning a new spoken language. Studies show that Morse code improves cognitive flexibility and activates areas of the brain responsible for linguistic learning.\nReady to unlock this skill? Let s dive in! 🚀")
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


