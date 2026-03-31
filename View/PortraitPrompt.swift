//
//  PortraitPrompt.swift
//  MorseMission
//

import SwiftUI

struct PortraitPrompt: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
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
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}
