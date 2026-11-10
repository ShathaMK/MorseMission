//
//  DecodePage.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 21/08/1446 AH.
//
import SwiftUI

struct TranslatorView: View {

    @ObservedObject var viewModel = MorseLettersViewModel()
    @StateObject private var TranslatorViewModel = MorseTranslatorViewModel()
    @State private var selectedMode: Mode = .encode // initall mode
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // PHONE

      enum Mode {
          case encode, decode
      }

    /// PHONE: true on every iPhone (any orientation, including Plus / Pro Max, which report a regular
    /// size class in landscape) and also on a narrow iPad window (Split View / Slide Over).
    private var isCompact: Bool { // PHONE
        horizontalSizeClass == .compact || UIDevice.current.userInterfaceIdiom == .phone
    }

   var body: some View {
       if isCompact { // PHONE
           phoneBody // PHONE
       } else { // PHONE: everything below is your original iPad layout, unchanged
       ZStack{
           Color("BackgroundColor").edgesIgnoringSafeArea(.all)



           HStack{

               VStack{

                   Spacer()

                   HStack {
                       Picker("Mode", selection: $selectedMode) {
                           Text("Encode")
                               .tag(Mode.encode)
                           Text("Decode")
                               .tag(Mode.decode)
                       }
                       .pickerStyle(SegmentedPickerStyle())
                       .padding(8)
                       .background(Color("DarkGrayColor").opacity(0.6))
                       .clipShape(RoundedRectangle(cornerRadius: 15))
                       .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color("PurpleColor"), lineWidth: 2)
                       )
                       .frame(width: 400)

                   }
                   // UI changes based on selected mode (Languages text fields switch)
                                 if selectedMode == .encode {
                                     encodeView
                                 } else {
                                     decodeView
                                 }


                       }

           }


       }
       } // PHONE
    }

    // MARK: - PHONE: iPhone layout (scrolls, fields use 90% of the screen width)

    private var phoneBody: some View { // PHONE
        GeometryReader { geo in
            let fieldWidth = geo.size.width * 0.9

            ZStack {
                Color("BackgroundColor").edgesIgnoringSafeArea(.all)

                ScrollView {
                    Spacer()
                    Spacer()
                    Spacer()
                    VStack(spacing: 20) {
                        Picker("Mode", selection: $selectedMode) {
                            Text("Encode").tag(Mode.encode)
                            Text("Decode").tag(Mode.decode)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(8)
                        .background(Color("DarkGrayColor").opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color("PurpleColor"), lineWidth: 2)
                        )
                        .frame(width: fieldWidth)
                        .padding(.top, 16)

                        if selectedMode == .encode {
                            phoneEncodeView(fieldWidth: fieldWidth)
                        } else {
                            phoneDecodeView(fieldWidth: fieldWidth)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 30)
                }
            }
        }
    }

    @ViewBuilder
    private func phoneEncodeView(fieldWidth: CGFloat) -> some View { // PHONE
        VStack(spacing: 16) {
            phoneField(
                label: "English",
                text: $TranslatorViewModel.englishText,
                placeholder: "Apple",
                width: fieldWidth
            )

            phoneField(
                label: "Morse",
                text: $TranslatorViewModel.morseText,
                placeholder: ".- .--. .--. .-.. .",
                width: fieldWidth,
                showSpeaker: true
            )
            Spacer()
            Button(action: {
                TranslatorViewModel.encodeEnglishText()
            }) {
                Text("Encode")
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(Color("FontColor"))
                    .frame(width: fieldWidth, height: 44)
                    .background(Color("PurpleColor"))
                    .cornerRadius(10)
            }
            .padding(.top, 8)
        }
    }

    @ViewBuilder
    private func phoneDecodeView(fieldWidth: CGFloat) -> some View { // PHONE
        VStack(spacing: 16) {
            phoneField(
                label: "Morse",
                text: $TranslatorViewModel.morseText,
                placeholder: ".- .--. .--. .-.. .",
                width: fieldWidth,
                showSpeaker: true
            )

            phoneField(
                label: "English",
                text: $TranslatorViewModel.englishText,
                placeholder: "Apple",
                width: fieldWidth
            )
            Spacer()
            Button(action: {
                TranslatorViewModel.decodeMorseCode()
            }) {
                Text("Decode")
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(Color("FontColor"))
                    .frame(width: fieldWidth, height: 44)
                    .background(Color("PurpleColor"))
                    .cornerRadius(10)
            }
            .padding(.top, 8)
        }
    }

    @ViewBuilder
    private func phoneField( // PHONE
        label: String,
        text: Binding<String>,
        placeholder: String,
        width: CGFloat,
        showSpeaker: Bool = false
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(.title3, design: .rounded))
                .fontWeight(.medium)
                .foregroundStyle(Color("FontColor"))
                .frame(width: width, alignment: .leading)

            ZStack(alignment: .topTrailing) {
                TextField(
                    "",
                    text: text,
                    prompt: Text(" \(placeholder) ")
                        .foregroundColor(Color("FontColor"))
                        .font(.system(size: 20))
                )
                .padding()
                .frame(width: width, height: 120, alignment: .topLeading)
                .background(Color("DarkGrayColor").opacity(0.6))
                .cornerRadius(25)
                .font(.system(size: 22, design: .rounded))
                .foregroundColor(Color("FontColor"))

                if showSpeaker {
                    Button(action: {
                        TranslatorViewModel.playTranslation()
                    }) {
                        Image(systemName: "speaker.wave.3.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 22)
                            .foregroundColor(Color("PurpleColor"))
                            .padding(14)
                    }
                }
            }
        }
    }

    // MARK: - iPad layout (your original code, unchanged)

    private var encodeView:some View{

        VStack{

            Spacer()

            Text("English")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.medium)
                .foregroundStyle(Color("FontColor"))
                .frame(maxWidth:771,alignment: .topLeading)
            TextField("", text:$TranslatorViewModel.englishText ,prompt: Text(" Apple ")
                .foregroundColor(Color("FontColor"))
                .font(.system(size: 35)))
                .padding()
                .frame(width: 770, height: 220, alignment: .topLeading)
                .background(Color("DarkGrayColor").opacity(0.6))
                .cornerRadius(25)
                .font(.system(size: 40, design: .rounded))
                .foregroundColor(Color("FontColor"))





            Spacer()
            Spacer()
            Text("Morse")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.medium)
                .foregroundStyle(Color("FontColor"))
                .frame(maxWidth:771,alignment: .topLeading)

            TextField("", text:$TranslatorViewModel.morseText ,prompt: Text(" .- .--. .--. .-.. . ").foregroundColor(Color("FontColor")).font(.system(size: 40)))
                .padding()
                .frame(width: 770, height: 220, alignment: .topLeading)
                .background(Color("DarkGrayColor").opacity(0.6))
                .cornerRadius(25)
                .font(.system(size: 40, design: .rounded))
                .foregroundColor(Color("FontColor"))
                .overlay(content: {
                    Button(action:{
                        TranslatorViewModel.playTranslation()}){
                        Image(systemName: "speaker.wave.3.fill")
                            .resizable()
                            .frame(width: 50, height: 40,alignment: .topTrailing)
                            .foregroundColor(Color("PurpleColor"))
                            .padding(.leading,650)
                            .padding(.bottom,130)
                    }
                })

            Spacer()

                       Button(action: {
                           TranslatorViewModel.encodeEnglishText()
                       }) {
                           Text("Encode").font(.system(.title,design: .rounded)).fontWeight(.bold).foregroundStyle(Color("FontColor")) // FIX: was "Enccode" (already "Encode" in your first version)
                               .frame(width: 770, height: 50)
                               .background(Color("PurpleColor"))
                               .cornerRadius(10)
                       }
            Spacer()
            Spacer()
            Spacer()

        }

    }



    private var decodeView:some View{

        VStack{

            Spacer()


            Text("Morse").font(.system(.largeTitle, design: .rounded)).fontWeight(.medium).foregroundStyle(Color("FontColor"))
                .frame(maxWidth:771,alignment: .topLeading)

            TextField("", text:$TranslatorViewModel.morseText ,prompt: Text(" .- .--. .--. .-.. . ").foregroundColor(Color("FontColor")).font(.system(size: 40)))
                .padding()
                .frame(width: 770, height: 220, alignment: .topLeading)
                .background(Color("DarkGrayColor").opacity(0.6))
                .cornerRadius(25)
                .font(.system(size: 40, design: .rounded))
                .foregroundColor(Color("FontColor"))
                .overlay(content: {
                    Button(action:{    TranslatorViewModel.playTranslation()}){
                        Image(systemName: "speaker.wave.3.fill")
                            .resizable()
                            .frame(width: 50, height: 40,alignment: .topTrailing)
                            .foregroundColor(Color("PurpleColor"))
                            .padding(.leading,650)
                            .padding(.bottom,130)
                    }
                })





            Spacer()
            Spacer()
            Text("English")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.medium)
                .foregroundStyle(Color("FontColor"))
                .frame(maxWidth:771,alignment: .topLeading)
            TextField("", text:$TranslatorViewModel.englishText ,prompt: Text(" Apple ")
                .foregroundColor(Color("FontColor")).font(.system(size: 35)))
                .padding()
                .frame(width: 770, height: 220, alignment: .topLeading)
                .background(Color("DarkGrayColor").opacity(0.6))
                .cornerRadius(25)
                .font(.system(size: 40, design: .rounded))
                .foregroundColor(Color("FontColor"))

            Spacer()

                       Button(action: {
                           TranslatorViewModel.decodeMorseCode()
                       }) {
                           Text("Decode")
                               .font(.system(.title,design: .rounded))
                               .fontWeight(.bold)
                               .foregroundStyle(Color("FontColor"))
                               .frame(width: 770, height: 50)
                               .background(Color("PurpleColor"))
                               .cornerRadius(10)
                       }
            Spacer()
            Spacer()
            Spacer()

        }

    }


}
