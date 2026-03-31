//
//  OrientationDetector.swift
//  MorseMission
//

import SwiftUI

struct OrientationDetector<Content: View>: View {
    @State private var isLandscape = false
    @State private var isAnimating = false
    @ViewBuilder let content: () -> Content

    var body: some View {
        ZStack {
            if isLandscape {
                content()
            } else {
                Color.black.ignoresSafeArea()

                VStack(spacing: 30) {
                    Text("Please Rotate Your Device")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    Text("This game is designed for landscape mode")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 40)

                    Image(systemName: "rectangle.portrait.rotate")
                        .font(.system(size: 80))
                        .foregroundColor(Color("PurpleColor"))
                        .rotationEffect(.degrees(isAnimating ? 90 : 0))
                        .padding(.top, 20)
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            let newOrientation = UIDevice.current.orientation

            if newOrientation == .faceUp || newOrientation == .faceDown || newOrientation == .unknown {
                return
            }

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

            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}
