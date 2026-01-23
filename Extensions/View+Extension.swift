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
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return UIScreen.main.bounds
        }
        return window.frame
    }
}
