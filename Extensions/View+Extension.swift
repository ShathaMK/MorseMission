//
//  File.swift
//  Morse Mission
//
//  Created by Shatha Almukhaild on 25/01/1447 AH.
//

import Foundation
import SwiftUI
// extension to get the screen width and height making it adaptive for all screen sizes
extension View {
    func getScreenBounds() -> CGRect {
        // For iOS 15+, use proper window scene access
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                return window.bounds
            }
        }
        // Fallback
        return UIScreen.main.bounds
    }
}
