//
//  MainPage.swift
//  MorseMission
//
//  Created by Shatha Almukhaild on 21/08/1446 AH.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = GameViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // PHONE
    //@State private var isLandscape = false

    /// PHONE: true on every iPhone (any orientation, including Plus / Pro Max, which report a regular
    /// size class in landscape) and also on a narrow iPad window (Split View / Slide Over).
    private var isCompact: Bool { // PHONE
        horizontalSizeClass == .compact || UIDevice.current.userInterfaceIdiom == .phone
    }

    var body: some View {
        ZStack{
            GeometryReader {geo in

                let isLandscape = geo.size.width > geo.size.height


                NavigationStack{
                    ZStack {
                        Color("BackgroundColor").ignoresSafeArea()

                        if isCompact { // PHONE
                            iPhoneLayout(w: geo.size.width, h: geo.size.height, isLandscape: isLandscape) // PHONE
                        } else if isLandscape{ // PHONE: was `if isLandscape{`
                            landscapeLayout(geo:geo)
                            //                            // Landscape - layout with dialogue
                            //                            VStack(spacing: 60) {
                            //                                HStack{
                            //                                    Image("SparkProfile").resizable().frame(width: 180, height: 180)
                            //
                            //                                    // Dialogue Box for Landscape
                            //                                    DialogueBox(
                            //                                        title: "Hello Detective 🕵️‍♂️",
                            //                                        text: "Your mission: master Morse code to crack the case. Dots and dashes will help you uncover hidden messages and catch the imposter lurking in the shadows.\nThe fate of WWDC25 is in your hands. Are you ready to begin? 🔍"
                            //                                    )
                            //
                            //                                    .frame(width: 805, height: 200)
                            //                                }
                            //
                            //                                HStack(spacing:120) {
                            //                                    Spacer()
                            //                                    NavigationLink(destination: AlphabetView()){
                            //                                        Image("Level1").resizable().frame(width: 250,height: 450)
                            //                                    }
                            //                                    NavigationLink(destination: TranslatorView()){
                            //                                        Image("Level3").resizable().frame(width: 250,height: 450)
                            //                                    }
                            //                                    NavigationLink(destination: FindSpyView(viewModel:viewModel)){
                            //                                        Image("Level2").resizable().frame(width: 250,height: 450)
                            //                                    }
                            //                                    Spacer()
                            //                                }
                            //                                Spacer()
                            //                            }
                        } else {
                            // Portrait - vertical stack
                            portraitLayout(geo:geo)
                            //                            ScrollView {
                            //                                VStack(spacing: 50) {
                            //                                    HStack(spacing: 10) {
                            //                                        Spacer()
                            //                                        Image("SparkProfile")
                            //                                            .resizable()
                            //                                            .frame(width: 200, height: 200)
                            //
                            //                                        // Dialogue Box for Portrait
                            //                                        DialogueBox(
                            //                                            title: "Hello Detective 🕵️‍♂️",
                            //                                            text: "Your mission: master Morse code to crack the case. Dots and dashes will help you uncover hidden messages and catch the imposter lurking in the shadows.The fate of WWDC25 is in your hands. Are you ready to begin? 🔍"
                            //                                        )
                            //
                            //                                        .frame(maxWidth: 500, maxHeight: 400)
                            //                                        Spacer()
                            //                                    }
                            //                                    .padding(.top, 60)
                            //
                            //                                    LazyVGrid(columns: [
                            //                                        GridItem(.flexible()),
                            //                                        GridItem(.flexible())
                            //                                    ], spacing: 80) {
                            //                                        NavigationLink(destination: AlphabetView()){
                            //                                            Image("Level1")
                            //                                                .resizable()
                            //                                                .frame(width: 280, height: 400)
                            //                                        }
                            //
                            //                                        NavigationLink(destination: TranslatorView()){
                            //                                            Image("Level3")
                            //                                                .resizable()
                            //                                                .frame(width: 280, height: 400)
                            //                                        }
                            //
                            //                                        NavigationLink(destination: FindSpyView(viewModel: viewModel)){
                            //                                            Image("Level2")
                            //                                                .resizable()
                            //                                                .frame(width: 280, height: 400)
                            //                                        }
                            //                                    }
                            //                                    .padding(.horizontal, 20)                            }
                            //                                .frame(maxWidth: .infinity)
                            //                            }
                        }// end of else
                    }// end of ZStack
                }// End of NavigationStack
                .accentColor(Color("PurpleColor"))
                .navigationBarHidden(true)

            }// End of Geometry reader
        }// End of ZStack
    }//end of body view

        // MARK: - PHONE: iPhone layout (from your first version)

        @ViewBuilder
        private func iPhoneLayout(w: CGFloat, h: CGFloat, isLandscape: Bool) -> some View { // PHONE
            if isLandscape {
                ScrollView {
                    VStack(spacing: 20) {
                        HStack(spacing: 12) {
                            Image("SparkProfile")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60)
                                .clipShape(Circle())

                            CompactDialogueBox(text: "Hello Detective 🕵️‍♂️\nYour mission: master Morse code to crack the case. The fate of DevSummit is in your hands. Are you ready to begin? 🔍")
                            //.frame(width: w * 0.6, height: h*0.15)
                        }
                        .padding(.horizontal, 160)
                        .padding(.top, 12)
                        .padding(.leading,-85)


                        HStack(spacing: 60) {
                            NavigationLink(destination: AlphabetView()) {
                                Image("Level1").resizable().scaledToFit().frame(width: w * 0.22)
                            }
                            NavigationLink(destination: TranslatorView()) {
                                Image("Level3").resizable().scaledToFit().frame(width: w * 0.22)
                            }
                            NavigationLink(destination: FindSpyView(viewModel: viewModel)) {
                                Image("Level2").resizable().scaledToFit().frame(width: w * 0.22)
                            }
                        }
                        .padding(.bottom, 12)
                    }
                    .frame(minHeight: h)
                }
            } else {
                ScrollView {
                    VStack(spacing: 24) {
                        HStack() {
                            Image("SparkProfile")
                                .resizable()
                                .scaledToFit()
                                .frame(width: w * 0.201)
                                .clipShape(Circle())

                            CompactDialogueBox(
                                text: "Hello Detective 🕵️‍♂️\nYour mission: master Morse code to crack the case. The fate of DevSummit is in your hands. Are you ready to begin? 🔍",

                            )
                            .frame(maxWidth: w * 0.59, maxHeight: h * 0.7)
                        }
                        .padding(.top, h * 0.08)

                        VStack(spacing: 20) {
                            HStack{
                                NavigationLink(destination: AlphabetView()) {
                                    Image("Level1").resizable().scaledToFit().frame(maxWidth: w * 0.4)
                                }
                                NavigationLink(destination: TranslatorView()) {
                                    Image("Level3").resizable().scaledToFit().frame(maxWidth: w * 0.4)
                                }
                            }
                            HStack{
                                NavigationLink(destination: FindSpyView(viewModel: viewModel)) {
                                    Image("Level2").resizable().scaledToFit().frame(maxWidth: w * 0.4)
                                        .padding(.trailing,165)
                                }

                            }
                        }
                        .padding(.bottom, 24)
                    }
                    .padding(.top, -40)
                    Spacer()


                }


            }
        } // end of iPhoneLayout

        // MARK: - Landscape
        @ViewBuilder
        private func landscapeLayout(geo: GeometryProxy) -> some View {
            ScrollView {
                VStack(spacing: 30) {

                    HStack {
                        Image("SparkProfile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: min(geo.size.width * 0.14, 140))

                        DialogueBox(
                            title: "Hello Detective 🕵️‍♂️",
                            text: "Your mission: master Morse code to crack the case. Dots and dashes will help you uncover hidden messages and catch the imposter lurking in the shadows.\nThe fate of DevSummit is in your hands. Are you ready to begin? 🔍"
                        )
                        .frame(width: min(geo.size.width * 0.65, 700))

                    } // end of HStack (image + dialogue)

                    HStack(spacing: geo.size.width * 0.03) {
                        levelButton("Level1", destination: AlphabetView(), geo: geo)
                        levelButton("Level3", destination: TranslatorView(), geo: geo)
                        levelButton("Level2", destination: FindSpyView(viewModel: viewModel), geo: geo)
                    } // end of HStack (level buttons)

                } // end of VStack (landscape content)
                .padding()
                .frame(minHeight: geo.size.height)
            } // end of ScrollView
        } // end of landscapeLayout

        // MARK: - Portrait
         @ViewBuilder
         private func portraitLayout(geo: GeometryProxy) -> some View {
             ScrollView {
                 VStack(spacing: 40) {

                     HStack(spacing: 10) {
                         Image("SparkProfile")
                             .resizable()
                             .scaledToFit()
                             .frame(width: geo.size.width * 0.22)

                         DialogueBox(
                             title: "Hello Detective 🕵️‍♂️",
                             text: "Your mission: master Morse code to crack the case. Dots and dashes will help you uncover hidden messages and catch the imposter lurking in the shadows. The fate of DevSummit is in your hands. Are you ready to begin? 🔍"
                         )
                         .frame(maxWidth: geo.size.width * 0.6)

                     } // end of HStack (image + dialogue)
                     .padding(.top, 40)
                     .padding(.horizontal, 20)

                     LazyVGrid(
                         columns: [GridItem(.flexible()), GridItem(.flexible())],
                         spacing: 40
                     ) {
                         levelImage("Level1", destination: AlphabetView(), geo: geo)
                         levelImage("Level3", destination: TranslatorView(), geo: geo)
                         levelImage("Level2", destination: FindSpyView(viewModel: viewModel), geo: geo)
                     } // end of LazyVGrid
                     .padding(.horizontal, 20)

                 } // end of VStack (portrait content)
                 .frame(maxWidth: .infinity)
             } // end of ScrollView
         } // end of portraitLayout

        // MARK: - Reusable pieces
        @ViewBuilder
        private func levelButton<Destination: View>(
            _ imageName: String, destination: Destination, geo: GeometryProxy
        ) -> some View {
            NavigationLink(destination: destination) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: min(geo.size.width * 0.18, 220))
            } // end of NavigationLink
        } // end of levelButton

        @ViewBuilder
        private func levelImage<Destination: View>(
            _ imageName: String, destination: Destination, geo: GeometryProxy
        ) -> some View {
            NavigationLink(destination: destination) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: geo.size.width * 0.4)
            } // end of NavigationLink
        } // end of levelImage

    } // end of MainView


//        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
//            let newOrientation = UIDevice.current.orientation
//
//            // IGNORE flat positions - keep current state
//            if newOrientation == .faceUp || newOrientation == .faceDown || newOrientation == .unknown {
//                return
//            }
//
//            // Only update for valid rotations
//            if newOrientation == .landscapeLeft || newOrientation == .landscapeRight {
//                isLandscape = true
//            } else if newOrientation == .portrait || newOrientation == .portraitUpsideDown {
//                isLandscape = false
//            }
//        }
//        .onAppear {
//            // Check initial orientation from interface
//            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//                isLandscape = scene.interfaceOrientation.isLandscape
//            }


//}

// Dialogue Box Component - with speech bubble arrow
// Dialogue Box Component (iPad - your original, unchanged)
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

// MARK: - PHONE: Compact Dialogue Box (used on iPhone)

struct CompactDialogueBox: View { // PHONE
    let text: String

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            SpeechBubbleTail(pointingUp: false)
                .fill(Color("DarkGrayColor"))
                .frame(width: 16, height: 26)
                .offset(x: 5)

            Text(text)
                .font(.system(size: 10, weight: .medium, design: .rounded))
                .foregroundColor(.white)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical, 12)
                .padding(.leading, 8)
                .padding(.trailing, 12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color("DarkGrayColor")))
        }
    }
}

// Speech bubble tail shape - triangle pointing left
// PHONE: now also supports pointing up; the default (false) is your original left-pointing tail, so iPad is unchanged
struct SpeechBubbleTail: Shape {
    var pointingUp: Bool = false // PHONE

    func path(in rect: CGRect) -> Path {
        var path = Path()
        if pointingUp { // PHONE
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            path.closeSubpath()
        } else { // PHONE
            path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            path.closeSubpath()
        } // PHONE
        return path
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        .previewDevice("iPhone 17 pro")
        MainView()
            .previewDevice("iPad Air 11-inch")
        MainView()
            .previewDevice("iPad Air 13-inch")
    }
}
