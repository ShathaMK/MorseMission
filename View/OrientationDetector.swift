import SwiftUI

struct OrientationDetector<Content: View>: View {
    @State private var orientationChanged = false
    @State private var isAnimating = false
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                if geo.size.height > geo.size.width {
                    // Portrait
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
                            .foregroundColor(.purple)
                            .rotationEffect(.degrees(isAnimating ? 90 : 0))
                            .padding(.top, 20)
                    }
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                            isAnimating = true
                        }
                    }
                } else {
                    // Landscape
                    content
                        .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            .id(orientationChanged) // Force re-render when orientation changes
        }
        .ignoresSafeArea()
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            orientationChanged.toggle() // Toggle to force re-render
        }
    }
}
